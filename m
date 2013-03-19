From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Mon, 18 Mar 2013 22:44:10 -0700
Message-ID: <20130319054410.GQ5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
 <20130319034822.GL5062@elie.Belkin>
 <7vli9kkoci.fsf@alter.siamese.dyndns.org>
 <CACsJy8AjqwGVRRiQGMG0AN5qqtvxLk8FHKfUzCZB-7BykrHfjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 06:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHpLn-0005xT-M2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 06:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab3CSFoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 01:44:16 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63477 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab3CSFoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 01:44:16 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so120759pbc.30
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 22:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DF62wF379564K3Bt8WwQKquJHSDgFw3pK5qsFzqz+Go=;
        b=cen1Ka5/Q9r5b5UDisQFYoqxopqnt/Qxc+5vARiOo5atrLMbOnHs9tmvEu1W4xeyTS
         hiaWPifII4u5OvRDnNZxwkOZO1aIwOSZzfn+HCw5qNEtWqbsFVHQ1SgZ/3l4Du7dtOQj
         jVS7m5rD7ysN8HZixbanIgQ/UBLSikWldTHEENj+RB6mLVRK+tlZmlK4XFPHAIDB8x7V
         K9SJvnJek/r7iGQCKG3pAhPbrhbrpVyMEGY4AasfXDCJxBW49E/stY7/PIrRdRWc6Ha+
         TOsXdBaVBxytpfSh8E8PHxbSQX+rfw3MiyjKi+8y9IR+t0jSFEfwFSQAEsdGueUMuFns
         JL9w==
X-Received: by 10.66.150.198 with SMTP id uk6mr1418971pab.57.1363671855755;
        Mon, 18 Mar 2013 22:44:15 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id 4sm22891832pbn.23.2013.03.18.22.44.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 22:44:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AjqwGVRRiQGMG0AN5qqtvxLk8FHKfUzCZB-7BykrHfjg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218485>

Duy Nguyen wrote:

> My concern is run full-tree diff can be expensive on large repos (one
> of the reasons the user may choose to work from within a
> subdirectory). We can exit as soon as we find a difference outside
> $prefix. But in case we find nothing, we need to diff the whole
> worktree.

Yes.  This is an argument for the single-diff approach that Junio
suggested, since at least it's not significantly slower than the
future default behavior ("git add -u :/").

Sysadmins and others helping to train users will need to make sure
people working on large repos understand that they can use "git add -u ."
to avoid a speed penalty.

Thanks for looking it over,
Jonathan
