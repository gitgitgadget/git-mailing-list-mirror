From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Tue, 11 Mar 2014 08:49:28 -0400
Message-ID: <531F0658.4000106@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu> <531DF079.9050909@kitware.com> <531E30D7.40208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 13:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNM73-0008EU-EN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 13:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbaCKMst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 08:48:49 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43868 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752628AbaCKMsq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 08:48:46 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]) (using TLSv1) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx8GLgLsZtYYMEaIE8QYtTYlVnzk1lz7@postini.com; Tue, 11 Mar 2014 05:48:46 PDT
Received: by mail-ie0-f176.google.com with SMTP id rd18so8527956iec.7
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 05:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0P427x7FNFEVw5V/xOqggLnipXgvdMiJciq7Jc3QJ1w=;
        b=MKVhHmLKv2e7hKhgmfekYYSA+WOa1rVsa3jqPqF1plBxOMLRxZF7GhhKxOWCDW4LLX
         FbnMwFaWwjIgGAAHVj3DlU6mwYwpf39QiL6A6ueo38i9+VPnFXkJI+ITNmw+4yjRiNLr
         8q/jAysidHGGVUohPiDzMmmSObsiYBNIDfdmSsw01NR0zgCSJyZleK4b/uC5JYBjCJFx
         /MIFbqrKFiXMqgCl9y/fX/kCRLYGtnT9Ehtk34WijagpKMEHZpTl06aq5QaY4EohMU27
         YajrE3WD9lmpq/f/0FssintgyJReOFL/pyCuWqZ+z7UAR0hCU7wzTOnl1zEGMeR/USBi
         y8Eg==
X-Gm-Message-State: ALoCoQkTBK7HDpmh5jdLMAFe1IaGVtnZsXsUWWMZldflLfOInJ37r0ZE/8lkvYSyt4sTlNbIKRVLXBouT25/xbCNeeG7TTxB8PN1P7F/aJWEeFMLonwR+kEjiE6CktJNExd44z/EuKGbfI2PYPJzOAAodcoBojDLYw==
X-Received: by 10.50.92.105 with SMTP id cl9mr24486994igb.22.1394542126141;
        Tue, 11 Mar 2014 05:48:46 -0700 (PDT)
X-Received: by 10.50.92.105 with SMTP id cl9mr24486987igb.22.1394542126055;
        Tue, 11 Mar 2014 05:48:46 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id vu3sm47128861igc.6.2014.03.11.05.48.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 05:48:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531E30D7.40208@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243862>

On 03/10/2014 05:38 PM, Michael Haggerty wrote:
> It seems to me that "-z" input will nearly always be machine-generated,
> so there is not much reason to accept the empty string as shorthand for
> zeros.  So I think that my version of the rules, being simpler to
> explain, is a slight improvement.

I agree.

> But your version is already out in the wild, so backwards-compatibility
> is also a consideration, even though it is rather a fine point in a
> rather unlikely usage (why use update rather than delete to delete a
> reference?).

I'm not using empty==zero with -z in any deployment.  Since the feature
is quite new, the behavior change is not silent, and it is easy to
construct input that works with both versions, I do not think we need
to worry about compatibility.

> or rewrite the documentation to describe my rules.

I prefer this approach.

Thanks,
-Brad
