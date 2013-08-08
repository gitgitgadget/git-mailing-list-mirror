From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 12:19:58 -0700
Message-ID: <7v61vg9eht.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 21:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Vkm-0007Kj-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966205Ab3HHTUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:20:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966162Ab3HHTUB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:20:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 582F2374BC;
	Thu,  8 Aug 2013 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vc6JU/AqaFXKsOQVqMgy1b+Ngww=; b=Vll8T+
	jjepcUlRvQPtSy25QbvwUP5ay6e/b0nKoz0yLETfBryKPCsc3XGrjdyv0/PjT4lE
	0MHDj+5L6mWFlU3MCxwviqNlhNpvuSjJqd0SHtUZEvC1KuvHyVPvE7EWKx0UG0uu
	8EZEbgO0hzALyXgc8Q3oVWtt+4v42+v5aKbq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyqx1mB/MxzBt4xttU7yFKAHQLCE8m7K
	aYbD3UdZJq8U8wRx7hg1+HSQ2f3bx7haaVY2/XzbAydZyMq7JCWMzpuWWt1CdRFk
	7BFxb5D3Uoqp/hqMTtZdTWokUm9+w5bQykQyNC3NivJfT9M7ZZUA22ZKOWBfIjsy
	xtVUE6XErXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D46E374BA;
	Thu,  8 Aug 2013 19:20:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CB83374B6;
	Thu,  8 Aug 2013 19:19:59 +0000 (UTC)
In-Reply-To: <ku0lqj$qvs$1@ger.gmane.org> (Damien Robert's message of "Thu, 8
	Aug 2013 17:51:15 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8471D86A-005F-11E3-B26B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231924>

Damien Robert <damien.olivier.robert+gmane@gmail.com> writes:

> Matthieu Moy  wrote in message <vpqfvukdy39.fsf@anie.imag.fr>:
>>> that confuses users.
>> 
>> ... but I do agree that the doc is really confusing. It would be much
>> better if the doc could be reduced to:
>> 
>> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
>> Please refer to the documentation of that command."
>
> If I may chime in as a user: what really confused me about git whatchanged
> is this part of man gitcore-tutorial:
>
>        To see the whole history of our pitiful little git-tutorial project,
>        you can do
>
>            $ git log
>
>
>        which shows just the log messages, or if we want to see the log
>        together with the associated patches use the more complex (and much
>        more powerful)
>
>            $ git whatchanged -p
>
>
>        and you will see exactly what has changed in the repository over its
>        short history.
>
> I had to go look at the source code to realize that nowadays git log and
> git whatchanged are basically the same functions with different defaults. A
> pointer to that in the man page of git whatchanged would definitively be
> helpful.

The "tutorial" was written in fairly early days of Git's history, in
order to primarily help those who want to use the plumbing command
to script their own Porcelain commands.  As it says at the very
beginning, the end-user tutorial to use Git's Porcelain is
gittutorial.txt and the user manual, not this document.

The above section primarily explains the use of diff-tree and it was
appropriate back when git-whatchanged was a script.  The intent of
the whole document, not just this section, was to tickle the
curiousity of the users and encourage them to see how the above
"much more powerful" whatchanged was implemented by going to the
source.

Which no longer is easy to do, as we have many Porcelains
reimplemented in C.

I think a good way forward is to rewrite the above to:

        To see the whole history of our pitiful little git-tutorial
        project, you can do

            $ git log

        which shows just the log messages, or if we want to see the
        log together with the associated patches, use

            $ git log -p

        and you will see exactly what has changed in the repository
        over its short history.

and show a skeleton scripted implementation of "git log" using the
plumbing commands which would be essentially "git rev-list" piped to
"git diff-tree --stdin".  Either have it as an example under
contrib/examples, or as part of the text in this section of this
document.
