From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one
 action multiple times
Date: Sat, 17 Aug 2013 13:34:58 -0700
Message-ID: <20130817203458.GB2904@elie.Belkin>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
 <7va9l3x34f.fsf@alter.siamese.dyndns.org>
 <51F83010.2060804@googlemail.com>
 <7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
 <51F8E81E.6000705@googlemail.com>
 <7vbo5itjfl.fsf@alter.siamese.dyndns.org>
 <520F9051.4040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 22:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAnDL-0000w8-Et
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 22:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab3HQUfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 16:35:04 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64308 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab3HQUfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 16:35:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so315860pad.32
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0WcDMbj6a1xRBwDSI32u/TNt1Ant+tZ3aKAi+bZFSeM=;
        b=rMiFprtB295LahIyLSq2MNCMzNEzTuCrzL2aFUSRZGzkJ1SM6AusuMbse1/6hINRxt
         AWKVPGshd6/4APFYKkMW6c4x+tx/T2Vt6MtnuD/YxyNleuBLUQIRAE6d+WGcOcWZWNVB
         ZJn6sBFuqIaDFWK/6qsnoQ6/d1SNob3YbzevvpxIVdOC95zHEUE/58rAutvZc/p9VWnr
         vUcxbuWl9m4hWJhWNnGEG5wtMmWzFl/zfZ+4FhkSZODnML0kDebIPFoXB6zoXpCqjmLZ
         yRwz2h5t4wN6YDXyM5DqNcHhp95ly7217hjoF10TBgQJmQZTHt7TM57hikRN99JDj9ix
         KwNA==
X-Received: by 10.66.178.143 with SMTP id cy15mr4622838pac.105.1376771702456;
        Sat, 17 Aug 2013 13:35:02 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id mr3sm5408797pbb.27.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 13:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <520F9051.4040600@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232470>

Stefano Lattarini wrote:

> Why not encourage the use of a standardized '--action' option instead?

Because it's an unpleasant UI. :)

> This can work with lesser compatibility headaches for both the commands
> taking mode options and the commands taking mode words:
>
>   "git submodule init"   becomes  "git submodule --action=init"
>   "git tag --delete TAG" becomes  "git tag --action=delete TAGNAME"

That looks like a bad change in both cases --- it involves more
typing without much upside to go along with it.  But

	"git submodule init"   gains synonym "git submodule --init"
	"git tag --delete TAG" stays as      "git tag --delete TAG"

looks fine to me.

In the long run, we could require that for new commands the 'action'
option must come immediately after the git command name if that makes
things easier to learn.

Thanks for some food for thought.

My two cents,
Jonathan
