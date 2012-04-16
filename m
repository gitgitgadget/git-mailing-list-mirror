From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 18:16:26 -0500
Message-ID: <20120416231626.GW12613@burratino>
References: <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
 <20120416224411.GU12613@burratino>
 <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJvA2-0006ZR-GU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab2DPXQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 19:16:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61401 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab2DPXQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 19:16:37 -0400
Received: by iagz16 with SMTP id z16so8079188iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tJxcYuljA8ZtbRXDuDSfLwv7WYhjt4E4oIYIqSnVnJY=;
        b=ARjiDyTJ9lulJd//RXAaDbfaeNXPpz56/0Ygx1nGy6F7aGlFU1Sadf6C21mTrLPetV
         /PVQ5DcWUyzRufH2C1utidsG7jVj51mM+50kIX5EuzlD4jC9SeFLIKo+T2WPfvAvCcwt
         x3+NboxPNuPO9QC0UPqnPSuSGD5eZaTpWocev+AaEY2PSAC5awaFlpQusHMo6uT0bs/q
         1ep+yFv2ehLqjjZF/bPet1p7l2NV7z2WJhUs6UKTPuRGMOWajnwlIpb6XAN+4yqXBL+t
         4uwpMBtUKizPqGcCfmbrei6f/FbNZLWRMv8ZhQyUPJQo1kkzipgiTr68u7CChAtvJAug
         JgVQ==
Received: by 10.50.181.164 with SMTP id dx4mr7555763igc.1.1334618196685;
        Mon, 16 Apr 2012 16:16:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i7sm12696836igq.11.2012.04.16.16.16.34
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 16:16:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195723>

Felipe Contreras wrote:

> What makes you think this is public? It's under the section '# helper
> functions', which doesn't seem to be public. Plus, it's repeated in
> rpm, rpmbuild, and rpmbuild-md5.

Ok, you win.  I hadn't realized we were having a debate, but now I do,
and you have won.

Can we get back to making the completion script nicer for human
beings that have been using it, please?

The following summary may sound annoyed, because I am.  On the other
hand I know you mean well and am grateful for your work.

I have said that the convention for bash completion scripts is to
precede all exposed identifier names with an underscore.  You
mentioned some old counterexamples that have been grandfathered in.
You mentioned that you do not trust me.  Your bash completion script
gets loaded immediately instead of being lazy-loaded, probably because
it is not in /usr/share/bash-completion/completions/.  You claimed
that nobody would _ever_ ask for bash completion support at the end of
their .profile and after their custom functions in .profile that do
something unrelated, though I used to do that for a long time and
Debian's default .bashrc loads /etc/bash_completion at the end, too.

I still maintain that namespaces are useful and we should follow the
conventional ones when they exist.  What is the next step?

Jonathan
