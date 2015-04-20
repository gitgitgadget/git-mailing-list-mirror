From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Tue, 21 Apr 2015 00:14:14 +0200
Message-ID: <20150420221414.GA13813@hank>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik@vger.kernel.org,
	=?iso-8859-1?Q?Elfstr=F6m_=3Cerik=2Eelfstrom=40gmail=2Ecom=3E?=@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 00:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkJxO-0000c7-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbbDTWOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2015 18:14:18 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33049 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbbDTWOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:14:17 -0400
Received: by wgin8 with SMTP id n8so193994411wgi.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SQ5PAVRoaIdt6og9xqVbZ0xRRsLnl/M9J4BIGDvaEmY=;
        b=NvRm04txtkXHzL56pEDdfFVzkmkG1mv+ZJEMmIy0hVVQI55RS7D72WJAv3F03K5QDg
         ROXhsuZ12l6KG3QSutuxDbH4LGsUs/WfzhRZnutQaGf0Dtkti19BvtNw38FVfr36QwNP
         iN6e36nl47mIkObs6qft7U2B1xYrnDRxZ1Xi5PBX0hh4tCNKhoglnYLkBuDURBuH3yxF
         5x4NFBG9qY7+0uD0IhJ8Qy7cSulOdwiau9JugZz3rp3Cz+N7N630B72oNMpPmQlYBAVE
         t/eZPYPVOO0/LnXy2MoWMRs3JOD5iTQ25w70ScFolPy0D9PiRAv9SH1hiys30aTrgjGI
         SoTg==
X-Received: by 10.180.72.230 with SMTP id g6mr9177wiv.39.1429568055778;
        Mon, 20 Apr 2015 15:14:15 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id z12sm29033813wjw.39.2015.04.20.15.14.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 15:14:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267505>

On 04/18, Erik Elfstr=F6m wrote:
> * Still have issues in the performance tests, see comments
>   from Thomas Gummerer on v2

I've looked at the "modern" style tests again, and I don't the code
churn is worth it just for using them for the performance tests.  If
anyone wants to take a look at the code, it's at
github.com/tgummerer/git tg/perf-lib.

I think adding the test_perf_setup_cleanup command would make more
sense in this case.  If you want I can send a patch for that.
