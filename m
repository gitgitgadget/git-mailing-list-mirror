From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Tue, 06 Oct 2015 14:09:23 -0400
Organization: Twitter
Message-ID: <1444154963.7739.30.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-41-git-send-email-dturner@twopensource.com>
	 <5612439E.4080200@alum.mit.edu> <1444094977.7739.24.camel@twopensource.com>
	 <20151006015806.GA4972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 20:09:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjWg6-0001Ls-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 20:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbbJFSJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 14:09:26 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36640 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbJFSJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 14:09:25 -0400
Received: by qkht68 with SMTP id t68so5111272qkh.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 11:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fizSgxODcnnjKwXY2ziis6x7b80u1k1qquprrXezZWM=;
        b=F854rojyQBbruj4lvbs7I+rzmwKoL+SjFBaJaYVmbGTmG2MyqobbJePVzzYCckjmcm
         pyvvXe3Iww+oBFTNJWsYgiH9qpCDvR7vUoKgrODlXFHZ5M0KSzG5znW2hETI9PBHlp9F
         DHAfcNIBxhaKPS3B9tptgPqtBONC86AyLUOOU0srvfHyZR5wRVgGH78UFBPSqGRULLY1
         jbe2nDGrDZum38mX5ywZV+T7BwKaX36z8b9ceC9RT9g3Kh7wUe5fWBiE74mtGIlv3qy1
         RVupaSOuH9lAv6CP8nK6kmb7zOfE6ZmfEiNzEF7UMu9ihN0UgF1qIaP3dlIBah83uKT3
         ne0Q==
X-Gm-Message-State: ALoCoQmImQbnSNcdj8Kwk23lHTSSRjjpL9JDvO5yxeUOlkldn8qcaZLn3UVxiYr+Vz4fcp0r/Gcp
X-Received: by 10.55.51.84 with SMTP id z81mr48970620qkz.21.1444154965156;
        Tue, 06 Oct 2015 11:09:25 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id z196sm14288725qhd.22.2015.10.06.11.09.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 11:09:24 -0700 (PDT)
In-Reply-To: <20151006015806.GA4972@sigill.intra.peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279157>

On Mon, 2015-10-05 at 21:58 -0400, Jeff King wrote:
> On Mon, Oct 05, 2015 at 09:29:37PM -0400, David Turner wrote:
> 
> > > Therefore, I don't think this can be merged without a bump to
> > > core.repositoryformatversion. Such a bump will tell well-behaved older
> > > Git clients keep their hands off the repository. (Of course repositories
> > > that use the files backend can continue using
> > > core.repositoryformatversion 0.)
> > > 
> > > I thought Peff proposed a way to do such a bump, including a way to
> > > extend repositories one by one with new features. But that was something
> > > that we were chatting about off-list.
> > > 
> > > I haven't reviewed the actual code in this patch yet but I wanted to get
> > > the above comment on your radar.
> > > 
> > > Michael
> > 
> > I'll fix this to upgrade to v=1 when the lmdb refs backend is in use,
> > and to give sensible error messages in a v1 repo if built without LMDB.
> 
> I think the relevant series is:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/272447
> 
> It did not seem too controversial, but it mostly got dropped amidst the
> release, and I haven't reposted it yet.

That patch will work perfectly for this use case.  I'll add it to my
series when I reroll, and set an extension.
