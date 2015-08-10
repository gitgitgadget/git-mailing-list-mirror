From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 1/2] worktrees: add find_shared_symref
Date: Mon, 10 Aug 2015 18:42:06 -0400
Organization: Twitter
Message-ID: <1439246526.5283.3.camel@twopensource.com>
References: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
	 <CAPig+cTBLx2Q0n2ZcA-QgwNQMHZm9G45ThHbGc+Orkz-6c5cUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:42:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvln-0006Ai-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbbHJWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:42:09 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33162 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933261AbbHJWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:42:08 -0400
Received: by igbpg9 with SMTP id pg9so79580104igb.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=yWRSkc+tLeAW5gxMFSr7wI886XhyHTZDXj7FEPMWInQ=;
        b=W3GprNaGKQan4JrAunbzb2LsCHOn7uHauYyNOuV5mQI6/BcougSnjmJoBe7i8pV5QR
         QMZdbnn8nr1AaOMZ8lvH1dPx61LgSikzxc5mjNuwgvfLfTVO2HxcVRF2z4n/fZvbNA0T
         nxNIFzc0OMBoQUbIiizo2uvpMQ4kZJjxkpzRDaLqdKTf+QVqSeUIoa7QBQYQxynjzkVK
         0RpP87HWmujxxxyj8L0xTnVd2i23jXO2TJ1SR3eByMd/0j+csE34ZMOTQN9EobWivaEB
         2Ce2cM87LsiIHnDTaSe6sQHsjD5sriSWPWQKaljs3Danos+vxfsSdPTT9bRpXYGgpqqV
         cTwg==
X-Gm-Message-State: ALoCoQkz5aAJY6Lf8WOnEGC7UD8yIqNKLStiDuBx18xR7Bu2TfhZ6lycdOoPm4uiB/bPkdfPlV5O
X-Received: by 10.50.122.102 with SMTP id lr6mr6403553igb.56.1439246527902;
        Mon, 10 Aug 2015 15:42:07 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d3sm205646igx.5.2015.08.10.15.42.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2015 15:42:07 -0700 (PDT)
In-Reply-To: <CAPig+cTBLx2Q0n2ZcA-QgwNQMHZm9G45ThHbGc+Orkz-6c5cUg@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275659>

On Mon, 2015-08-10 at 18:30 -0400, Eric Sunshine wrote:
> On Mon, Aug 10, 2015 at 1:52 PM, David Turner <dturner@twopensource.com> wrote:
> > worktrees: add find_shared_symref
> 
> s/worktrees/branch/ perhaps?

Do you mean "this is in branch.c, so should be labeled with branch"?  

Because this change is mostly about non-branch refs, so I think saying
"branch" is confusing.  That's why I labelled it "worktrees"; that's the
broad topic that's being addressed.

> > Add a new function, find_shared_symref, which contains the heart of
> > die_if_checked_out, but works for any symref, not just HEAD.  Refactor
> > die_if_checked_out to use the same infrastructure as
> > find_shared_symref.
> >
> > Soon, we will use find_shared_symref to protect notes merges in
> > worktrees.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> > This version addresses Eric Sunshine's comments on v5.  It fixes an error
> > message and cleans up the code.
> 
> All issues identified in previous versions seem to have been
> addressed, and nothing else pops out at me. Thanks.
