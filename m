From: David Turner <dturner@twopensource.com>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 13:23:03 -0400
Organization: Twitter
Message-ID: <1460654583.5540.87.camel@twopensource.com>
References: <570D78CC.9030807@zytor.com>
	 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
	 <1460502934.5540.71.camel@twopensource.com>
	 <20160414015324.GA16656@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:25:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aql1i-00007y-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 19:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbcDNRXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 13:23:11 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35118 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbcDNRXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 13:23:07 -0400
Received: by mail-qk0-f182.google.com with SMTP id o6so31250349qkc.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EeE0FrfVp93RfgklpfDOZmaaPtuFst6XBATXpgF3XWM=;
        b=dmuKGhq2YIyHOXIrho1/hbtQpEh+U8ty+//Y2axTkal9B8yS7jrSCRV+23q9q0/tg8
         Vcb15REqTSTqrvqJ/Pwh+pfiWPok96FHe5xR54uWWG6BYgCCIyZVlFM77gb3+hSTniEJ
         w2pTbLFJiDIoSY+fvNtyNySphcgHB38us6WZkO7nJT85abK5bKcUu44gADxqijJQiIcE
         WB7uB/82wTkDc+c9MtLn1Wl1Sww62uPleWNIKBAmchyu54ibnx0yrfOvL2Nns4FygH64
         ct3vJZ4h6f4Pxgd1HIUyE+N6bqyKX/fraOWGUeJZ98/hSReNYcqpOYT8Quhz4JoR36wg
         YbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EeE0FrfVp93RfgklpfDOZmaaPtuFst6XBATXpgF3XWM=;
        b=WeLLxo9+LvA0hOM/IIGxC/lMPdraOmWxnZMxoSINWS9dl5PPBE7ICCXvUuM+syxW3f
         jKZBVTJ+Bsfb0iB5yG3h1i/sPMHUIPeezBROPhEGYgthvLT8Nd2aAbcly8v0P2oxHTvW
         9OEpeftDvppL86SXrEEjSXWws3BOASbjwXKHDgPlKOaK3xRAlbdLUvIBcTCDThPMOngB
         YMmGMW7GWY+fMjWDQkBcQjmXf9pwHshbXoNNm7t5qmF/ILQz5yWYDwiMIFH7R+igyng7
         ZTATSB+Omh9n7sg7s6qWtR5WnjmhCsJUrcie81r1ADpbA+fXlN9/pNJP8Fg4lyGBYY5E
         wBSw==
X-Gm-Message-State: AOPr4FW5HMUpjlnLTKWTNcpQUfxL20/0qnmkGCeQFQtqVNKT+/f/l0gFyFF4ssT2DjnZyg==
X-Received: by 10.55.17.102 with SMTP id b99mr19861132qkh.86.1460654585512;
        Thu, 14 Apr 2016 10:23:05 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 131sm17030098qhk.15.2016.04.14.10.23.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2016 10:23:04 -0700 (PDT)
In-Reply-To: <20160414015324.GA16656@thunk.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291537>

On Wed, 2016-04-13 at 21:53 -0400, Theodore Ts'o wrote:
> On Tue, Apr 12, 2016 at 07:15:34PM -0400, David Turner wrote:
> > 
> > If SHA-1 is broken (in certain ways), someone *can* replace an
> > arbitrary blob.  GPG does not help in this case, because the
> > signature
> > is over the commit object (which points to a tree, which eventually
> > points to the blob), and the commit hasn't changed.  So the GPG
> > signature will still verify.
> 
> The "in certain ways" is the critical bit.  The question is whether
> you are trying to replace an arbitrary blob, or a blob that was
> submitted under your control.
> 
> If you are trying to replace an arbitrary blob under the you need to
> carry a preimage attack.  That means that given a particular hash,
> you
> need to find another blob that has the same hash.  SHA-1 is currently
> resistant against preimage attack (that is, you need to use brute
> force, so the work factor is 2**159).  
> 
> If you are trying to replace an arbitrary blob which is under your
> control, then all you need is a collision attack, and this is where
> SHA-1 has been weakened.  It is now possible to find a collision with
> a work factor of 2**69, instead of the requisite 2**80.
> 
> It was a MD5 collision which was involved with the Flame attack.
> Someone (in probably the US or Isreali intelligence services)
> submitted a Certificate Signing Request (CSR) to the Microsoft
> Terminal Services Licensing server.  That CSR was under the control
> of
> the attacker, and it resulted in a certificate where parts of the
> certificate could be swapped out with the corresponding fields from
> another CSR (which was not submitted to the Certifiying Authority)
> which had the code signing bit set.
> 
> So in order to carry out this attack, not only did the (cough)
> "unknown" attackers had to have come up with a collision, but the two
> pieces of colliding blobs had to parsable a valid CSR's, one which
> had
> to pass inspection by the automated CA signing authority, and the
> other which had to contain the desired code signing bits set so the
> attacker could sabotage an Iranian nuclear centrifuge.
> 
> OK, so how does this map to git?  First of all, from a collision
> perspective, the two blobs have to map into valid C code, one of
> which
> has to be innocuous enough such that any humans who review the patch
> and/or git pull request don't notice anything wrong.  

It looks like Linux contains at least some firmware which would be hard
to audit.  One random example is:
firmware/bnx2x/bnx2x-e1h-6.2.9.0.fw.ihex
