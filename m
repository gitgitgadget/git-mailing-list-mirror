From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 4/8] refs: factor delete_ref loose ref step into a
 helper
Date: Mon, 02 Sep 2013 13:19:44 -0400
Message-ID: <5224C8B0.20206@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <aa8dc7fb089894b43fdf25e2e0e144229db544a6.1377885441.git.brad.king@kitware.com> <52221A15.20804@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXon-0000Nb-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758564Ab3IBRVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:21:34 -0400
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:32816 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756557Ab3IBRVd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:21:33 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]) (using TLSv1) by na3sys009aob118.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJHJiYlBsNRN0HyzuQExWhuQLfmERT@postini.com; Mon, 02 Sep 2013 10:21:33 PDT
Received: by mail-ob0-f170.google.com with SMTP id eh20so4835969obb.15
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NHMOOjxBQ2AggYfFy3jxW++Ekc6Sqf9Yo5MGro/BWTM=;
        b=OK/hAtcWHN8Pqx/qzoLq83tuE00V95wt2TZpTT5RSY3o0YDl+GTJj4pjTc8NXHv32t
         qo7GGSQ2nPayrMPTdFxGhQ5BqXd5ctZhjNUHCLKknvr+Bgq0dDiTaPK9Xc6bFltSZXHM
         UXXNZHwD6y7kVc5pJ41SYwqkXouP0NR9CVRj0rQ8FjEvQF1e2VxDxGGvCV9TVQWreupr
         hBFF6c9HvjV0lYoG84XeDiNBXBV1VUu6hTjTSicwgRnlJqcnAeKHx4QWnztFE3BbAlY2
         CatyuA6CqE3l9fuZYIOYNAZHrOJHp4JAMYdBKFpPVb301dAmMtxR4Zfd6TOxCX/tY6F5
         aHaA==
X-Gm-Message-State: ALoCoQnjS7mjRagyul8ZdF8MUS/dXU/TZ9zACh1ksVY2PQGP+Y3Zq2SPLKJazVY6iFq3tn80gJMMLiTTpsg99/U3IgSsXAHutJtQ1b0Xt8pf11+jIW0AemRP0t3Lc5ibgPudZX2j9JBBIxxfd6dxCq28BNyxR76JZg==
X-Received: by 10.60.60.105 with SMTP id g9mr17763645oer.8.1378142492493;
        Mon, 02 Sep 2013 10:21:32 -0700 (PDT)
X-Received: by 10.60.60.105 with SMTP id g9mr17763638oer.8.1378142492419;
        Mon, 02 Sep 2013 10:21:32 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id it7sm13897718obb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:21:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <52221A15.20804@alum.mit.edu>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233638>

On 08/31/2013 12:30 PM, Michael Haggerty wrote:
> Given that ret is only returned, you could restore the filename before
> the if statement and replace the ret variable with an immediate return
> statement:

Good idea.  Fixed in next revision.

Thanks,
-Brad
