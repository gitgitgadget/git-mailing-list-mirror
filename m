From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 11:40:43 +0200
Message-ID: <e5bfff550606040240p61dfcddaw987da180358c40fb@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <17538.16015.53244.876090@cargo.ozlabs.ibm.com>
	 <e5bfff550606040008m4dbf02bdga4f4e6bc2d2fe9d@mail.gmail.com>
	 <7vk67xclx7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 11:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmp6P-0002xT-Qy
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWFDJkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFDJko
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:40:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:33156 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751385AbWFDJkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 05:40:43 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1141642wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 02:40:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n0PWoeBQsX0bSsohNxcRPtFkSBqRb8VSrlUihJO/Q+mlI9JUNJ4qYSVLfTC7m3Vajns4N9kyQ2yNzsfHF9URJBJPJLIlQzcpN3r/D+uxAInytUn7/cnlybaTrmFhdKECIIe7htKS2iF39w0hc3FZhfa4pctEhobULG/NLYAfpKc=
Received: by 10.65.15.5 with SMTP id s5mr2798445qbi;
        Sun, 04 Jun 2006 02:40:43 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 02:40:43 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk67xclx7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21257>

On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > What you suggest we need it's a kind of history of tags.
>
> I do not understand what you mean by "history of tags".  Are you
> talking about "tag v1.0.0 was pointing at X commit yesterday but
> now today it points at Y commit"?
>
> > And, according to Paul suggestions, not only tags, but merge revisions
> > between tags.
> >
> > A more general and IMHO very powerful tool could be something like
> >
> > git-rev-list --top-order --parents --selected-only HEAD -- <sha 1>
> > <sha 2> .....  <sha n>
> >
> > Where git rev list gives the history, with modified parents, of the
> > given revisions _only_ plus the merging revisions among them.
>
> You completely lost me here.  The '--' markers are to mean "from
> here on the parameters are not revisions but are path limiters",
> so you are doing something else.  What are these <sha1#1>, <sha1#2>,...
> in this?  Are they revisions (i.e. commit object names)?

Yes they are.

Insted of path limiters I meant revisions limiters.

Given a revision history like

a
b--|
|   f
|   g
c
d
e

git-rev-list --top-order --parents --selected-only HEAD -- <a>  <g>  <d>

Should output something like

a
b--|
|   g
d

Of course with modified parent information as does git-rev-list
--parents -- foo.c
