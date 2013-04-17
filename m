From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 20:59:05 +1000
Message-ID: <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com> <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 12:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQ5V-0004ku-4C
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 12:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965627Ab3DQK7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 06:59:36 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38309 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936303Ab3DQK7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 06:59:36 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so1299387obb.35
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NT21jy8EJNpSsfgJ/d6iMkFJgAIqCSA61/8hZWWW1xk=;
        b=nBLtqNvOYl0Bzc0jYEM/jiZAlPSr118FLU2YhX0uenovV4//++kIE5ne63rPVKbVxF
         cDN8ud6X1LW9rO54rYNJgV5Y50UB5xtChmnVnpuDWmtIk9al7ut8K/9uvy0yIlqMw0m/
         OXYFoXWRJgZvqP+Bdz6Fb6YzddSVwYd0C4nxf5ZUGJD5lMWU/mqwvuiWeLyCIrrv/Y9o
         jWwGtCnpB2z1VjZi+K7BOzpxn49SNgdaRGdY2f+nPpzq1mS3aiJ/UsyrBnOFGNOhhnr2
         N9t7SMWODfpI8/9AebrICcGhkcVgZVZDWzMGgqYqbpb/LdaGqlfvzH0oJr+V8lUFc2gz
         9vqg==
X-Received: by 10.182.19.135 with SMTP id f7mr2204199obe.95.1366196375693;
 Wed, 17 Apr 2013 03:59:35 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 03:59:05 -0700 (PDT)
In-Reply-To: <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221533>

On Wed, Apr 17, 2013 at 8:53 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> What if I clone a repo then realize it was a mistake and remove it?
>> With current clone, a "rm -rf" would do. With this, I'll need to
>> figure out which subdir in the top .git contains the repo I want to
>> remove. I'm not sure how "git submodule" handles this case though
>> (i.e. total submodule ignorant speaking..)
>
> Currently, submodules relocate the GITDIR of submodules to
> .git/modules.  So, my proposed patch doesn't make the situation any
> worse.  In fact, it improves the situation because you're guaranteed
> that all your GITDIRs will be in ~/bare (or whatever your
> core.submoduleGitDir is), as opposed to a complex path in .git/modules
> of your containing superproject.

No, submodule code does not change "git clone". If I'm not mistaken,
submodule will not kick in until you type "git submodule something".
If I turn clone.submoduleGitDir on, how can I undo my mistake in a
user friendly way?
--
Duy
