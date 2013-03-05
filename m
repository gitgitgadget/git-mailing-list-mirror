From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Strange remote interaction
Date: Mon, 04 Mar 2013 21:21:47 -0800
Message-ID: <7v1ubuwhec.fsf@alter.siamese.dyndns.org>
References: <CALZVapm32S2XqA48KCmfr8O5PVSNMgRj=JfRm_yyYz6N6wE0=A@mail.gmail.com>
 <CALZVapnDyF7m=R7xrjUJUtyr9xVUeDnL4tQSCoM2ze8GSuUUyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 06:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCkKU-0003Ik-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 06:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785Ab3CEFVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 00:21:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3CEFVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 00:21:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CF02BD79;
	Tue,  5 Mar 2013 00:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyjPgq14HjSUJ0sKoVqK182/KcU=; b=FLNUxm
	UcrN5ghTgSiFw8SZUEcrpzNiQlWco1C1m8Hir0cDhN3nvqZ4XcPBytv2E6WbVGvU
	M9dL51crNKyjQjaP0tBBe/pnMFn+bU4AtcOJY7DeG/UIeHbPb9APy1vpBS6rI3+U
	xbBfa17DntJURgPyW2cRoJVj3vGUk5eRGDo54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t2m16nP6lx/2HGV6hbgOpTo9tDR7fiKy
	uQ267iAH3Cu8ACws5NJh4jwaFNImx6u0Wv2JBSbgGWRmF2CVO4/l2YZY0ns9T93I
	2HBoSb+3KlJjOq+KkkdTsYTWXAdK0ejm0iW2OJGxSHy2K5gY8eB8iRIQb6eHXIH0
	M1nIq51CjPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F846BD78;
	Tue,  5 Mar 2013 00:21:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699A6BD70; Tue,  5 Mar 2013
 00:21:49 -0500 (EST)
In-Reply-To: <CALZVapnDyF7m=R7xrjUJUtyr9xVUeDnL4tQSCoM2ze8GSuUUyg@mail.gmail.com> (Javier
 Domingo's message of "Tue, 5 Mar 2013 02:11:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94C7B6B6-8554-11E2-99FD-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217428>

Javier Domingo <javierdo1@gmail.com> writes:

> I have just had the attached bash session, and I have no idea on what
> is going on.
>
> Any help appreciated,
>
> Javier Domingo
>
> javier@frodo:~/proyectos/pfc$ git push -vvv javier master
> Pushing to git@server:javier/pfc
> To git@server:javier/pfc
>  ! [rejected]        master -> master (non-fast-forward)
> error: failed to push some refs to 'git@server:javier/pfc'
> hint: Updates were rejected because a pushed branch tip is behind its remote
> hint: counterpart. Check out this branch and merge the remote changes
> hint: (e.g. 'git pull') before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.

So push is going to git@server:javier/pfc repository, while ...

> javier@frodo:~/proyectos/pfc$ git fetch -vvv javier 
> From server:javier/pfc
>  = [up to date]      master     -> javier/master

... fetch/pull goes to server:javier/pfc repository.  Are they the
same?

In a usual set-up, an access to git@server:javier/pfc will first
locate the home directory for the user "git" (the token before "@"),
and then its subdirectory javier/pfc, e.g. /home/git/javier/pfc,
while an access to server:javier/pfc will first locate the home
directory of whatever username the ssh connection uses by default
(typically the local user but ~/.ssh/config may have "User"
directive for the server) and then its subdirectory javier/pfc,
e.g. /home/javier/javier/pfc.  These two may be different locations.

Do these two commands show the same output?

	$ git ls-remote git@server:javier/pfc refs/heads/master
        $ git ls-remote server:javier/pfc refs/heads/master

If the above conjecture is correct, I suspect they don't.
