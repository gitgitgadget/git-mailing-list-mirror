From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: is there a way to reference the branch point?
Date: Fri, 29 Jan 2010 23:35:18 +0100
Message-ID: <fabb9a1e1001291435p59599f62hd54cbca66d91c24b@mail.gmail.com>
References: <18219.1264804157@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazRI-0007fM-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab0A2Wfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813Ab0A2Wfj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:35:39 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59002 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0A2Wfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:35:38 -0500
Received: by pxi12 with SMTP id 12so2056659pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xYF6Gn6OFQnmLY2JAuPeskPVCWeCZIG5OGM4TNvU0+s=;
        b=v99D8O9YGjDA0ftPxnp+j0IrwX+57Km4E1tpzC50cT6bdfuNfLDNU0hcodJVdhowsi
         tT7xyzrb1LhGabGzM38IqYEF+jFsaEirwK7NK4kovuvH/iXqhHkJY49goki+q4RnW+24
         8uTVaqoYc7fIFjk8pAOce+OGNt4gHzbctsRwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qGNuVAfyeIUWjTosM1Lh1/x1Gr8UazLTtEGL4MSxN8hqviaTQsZk48dOcSKxyUO7Ka
         soKuL2MtGqnS+Fy8evEVEJ8bAZXJthU26B8AuyeqTe4j1vvqQAHjDYyLY2ZlYLvcxJP9
         cJ+GoBvwQDCd8LV8fVQeoQ9MN44f3vJ66yLg4=
Received: by 10.142.196.3 with SMTP id t3mr968272wff.10.1264804538168; Fri, 29 
	Jan 2010 14:35:38 -0800 (PST)
In-Reply-To: <18219.1264804157@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138391>

Heya,

On Fri, Jan 29, 2010 at 23:29, layer <layer@known.net> wrote:
> If I make a branch `foo' off master, commit a bunch of times, is there
> a way to reference the place on master from which I branched?

Depends, if you make a new branch from master, you can use 'git merge-base', so:

$ # on master
$ git checkout -b foo-topic-branch
$ # work work
$ git commit
$ # work work
$ git commit

Now you want to know where you branches off from master:

$ git merge-base foo-topic-branch master

That will show you the commit you branches off from, even if master
has grown new commits since then.

-- 
Cheers,

Sverre Rabbelier
