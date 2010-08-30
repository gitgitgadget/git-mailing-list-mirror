From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 21:12:05 -0500
Message-ID: <20100830021205.GJ2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
 <20100829212419.GC1890@burratino>
 <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
 <20100829223218.GL1890@burratino>
 <AANLkTik3H6hVgViAX5ur9Tq4tFQ9mJEPuTmAwcrLStvU@mail.gmail.com>
 <20100830020236.GH2305@burratino>
 <AANLkTimNsVeGLB5=y8WyLqdkiQFwoBkdp_YrfuuT_5Ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Optsh-00049l-1J
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab0H3CNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:13:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38433 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0H3CNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:13:49 -0400
Received: by gwj17 with SMTP id 17so1823321gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z/gHpQqvZF8dXCQJT0W0GMopGbpqWkOCmKb+dPQE83I=;
        b=IsnD2rX+FHHJOFbJvDcxViy5f6AqctDOHBI2SoHnOx7ryOSjipaKc869UfH+Sv6/ww
         uvZ1g9tCYOfYnD28G0r/IwMOzEgSsTBKAsSz4wK1cdf3IQ59k2FftyPURbyNwGOKU808
         9lWqtFfD2XelIurd2aDG4iH/O7IlU7kh3iPSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qK14ZdaxOtLm3WpKSlDo7hc9IhWKOLdDMPwthinly7tySLl+x3CDQ4UOA5sc6+BhSt
         w3wbyzUzeXGdktMethSFLfpLMU3xjwX0S6frcWzf76ueL1iFGIovVpa8xnK8rXvBJh4D
         JLWua2BA/wmVBUplkKHKcrZCutB6on2/9QmNw=
Received: by 10.100.168.11 with SMTP id q11mr3779854ane.178.1283134429057;
        Sun, 29 Aug 2010 19:13:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x19sm7591716anc.25.2010.08.29.19.13.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimNsVeGLB5=y8WyLqdkiQFwoBkdp_YrfuuT_5Ec@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154751>

[out of order for convenience]
Sverre Rabbelier wrote:

> Does it matter much which way the importer is called? If it ends early
> at a valid point nobody will know regardless of how it is called, no?

If the importer calls fast-import itself, it can

 1. close the pipe to fast-import
 2. wait for fast-import to exit
 3. print a relevant message
 4. exit

> I think it makes sense to say that if you issue a 'feature done', we
> change the code that checks for EOF to error instead of quit.

Ok. :)
