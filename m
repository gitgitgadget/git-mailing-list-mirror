From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Add tcsh-completion support to contrib by using
 git-completion.bash
Date: Wed, 14 Nov 2012 01:11:59 +0100
Message-ID: <20121114001159.GA14631@goldbirke>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
 <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
 <CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQaX-0000vz-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 01:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab2KNAMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 19:12:03 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:58573 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab2KNAMC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 19:12:02 -0500
Received: from localhost6.localdomain6 (p5B13079E.dip0.t-ipconnect.de [91.19.7.158])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LdEVV-1SqX3p1QTx-00j54Y; Wed, 14 Nov 2012 01:12:00 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3imos4DksroRkZ3K6una5H916gvtqttJQna8yGG8XhsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:46+SzbQ3oP6ELb9LpZEAC7aD2r7dvnWXP8yJhi7D/WX
 kRyzILKEWmTZmgupW1r4632T2M/w0Nb9SkPwSWu5+5GIMP/Vk6
 fgXxFAnPwFzZzcWglx0yKdC16tdSfZ7wzBA69retY6SuX69TgX
 jZpyVZF+Khid/GsUqZe1rfeSAhYIO9DtybXdmuFMKPXWo6/+Jw
 jYNuwWzQxsD0yokTiuG/2obX0aWgipeBNJ1RMpw0YMH6OVBrYr
 8DN69DXBQ/7C650HDWWsdaiq2K12wM0ybAaCT7MoWbimE/D7cm
 PTV3z3Oe4E46B1UBDm4lzLJ9Pr24SuLSeXFUsDDz5CadT2yCnh
 AzaLPBVdzT+h+Hw7ohIzTEGO6XmahwTCQvf1ikcee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209690>

On Tue, Nov 13, 2012 at 07:31:45PM +0100, Felipe Contreras wrote:
> On Mon, Nov 12, 2012 at 9:07 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> > +       # Call _git() or _gitk() of the bash script, based on the first
> > +       # element of the command-line
> > +       _${COMP_WORDS[0]}
> 
> You might want to use __${COMP_WORDS[0]}_main instead.

That wouldn't work.  __git_main() doesn't set up the
command-line-specific variables, but the wrapper around it does.


> > +# Make the script executable if it is not
> > +if ( ! -x ${__git_tcsh_completion_script} ) then
> > +       chmod u+x ${__git_tcsh_completion_script}
> > +endif
> 
> Why not just source it?

The goal is to re-use a Bash script to do completion in tcsh.  They
are two different breeds, tcsh doesn't grok bash.  So sourcing the
completion script is not an option, but we can still run it via Bash
and use it's results.
