From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: link to toggle 'no merges' option
Date: Thu, 17 Dec 2009 21:41:10 +0100
Message-ID: <cb7bb73a0912171241j56ecd2f1y3dc66cf3b86bd784@mail.gmail.com>
References: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<200912171637.45810.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLNAI-00063S-01
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 21:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764870AbZLQUld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 15:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764856AbZLQUld
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 15:41:33 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39740 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbZLQUlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 15:41:32 -0500
Received: by bwz27 with SMTP id 27so1770019bwz.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MD0giuA4NIzNgPDAZ9dT/5uVDn3sEfkFg6ecqjkkSoI=;
        b=W8Vs75ORhh+JHAOYsCwDLWpNMdu5jHVQdBM8x85V9HnoD2vltoEDfFw05lM6gPm/zy
         dl99HFBX4cDXNgkRmdVd/XZiXs9xLjBNXdtdg4/8GaKpDQONoVoiQeWj2ORv4j4frapz
         SjQIymRDA9OPh5N8BNb/hIEozdFuLCv5VJ0Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jfL2a95ruABZ6zSzkMgS6sBcwaZnZ4SAMi6VC7Er1esPaZ1xnrgZmFhJwYk72zIwwV
         zG5B9RtiTYY5DAlusPzfN+SVsi2X7Ic+ugNelkmPFklvLju5aLSExi5cWNyzMTU9ezMw
         Odx2P/JRtTYInvr9MiCLa1lefE2EyRyiFf884=
Received: by 10.204.155.92 with SMTP id r28mr1741147bkw.121.1261082490440; 
	Thu, 17 Dec 2009 12:41:30 -0800 (PST)
In-Reply-To: <200912171637.45810.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135382>

2009/12/17 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 17 Dec 2009 10:05 +0100, Giuseppe Bilotta wrote:
>> This is something I've been wanting for a while. There are a number =
of
>> things that don't 'click' with this proof of concept, and I'm coming=
 to
>> the list to hear the opinion of users and developers on how to impro=
ve
>> the thing.
>>
>> The patch is live at http://git.oblomov.eu/, an example affected pag=
e is
>> http://git.oblomov.eu/git/shortlog
>
> You should tell here that one must put mouse over main header (the on=
e
> with 'projects / project / action' breadcrumbs) for the new link to b=
e
> visible... because I was wondering where is this new link.

I mentioned it right below, but I do realize that people might have
gone looking for it before reading further down ;-)

>> Things that are sure to change:
>>
>> =A0* the aesthetics and location of the toggle link (it shows on mou=
sehover
>> =A0 =A0in the title).
>
> It is not only the question where to put link, but also where to put
> the *code* (where the code should belong to).
>
> At first I thought: WTF? Why the feature that deals with log-like vie=
ws
> is put in very generic and common for all actions/views git_header_ht=
ml
> subroutine? =A0Especially after change that made all loglike views us=
e
> common infrastructure of git_log_generic.
>
> But then I realized that it is specific example of *generic* feature
> that deals with extra_options... which admittedly is currently limite=
d
> to '--no-merges' only. =A0So if it is put in git_header_html, then al=
l
> views with HTML output (which does not include 'atom' and 'rss' actio=
ns,
> but which actions IIRC have their own handling of '--no-merges')
> which have support for extra_options would have ability to turn them
> on and off.

Exactly. Although the code as it is now is not really flexible enough
to handle other cases. I see further down a couple of your ideas would
make this kind of thing more extensible.

> What you need to add (if this link is to be in git_header_html) is
> to create links only when $status =3D=3D 200, because otherwise the l=
ink
> would be present also for error pages, which I think is wrong.

Good point. That's an easy fix too 8-)

>> =A0 =A0Other options I've considered are:
>> =A0 =A0 + next to pagination (first | prev | next), either before or=
 after
>> =A0 =A0 =A0 the existing entries
>
> This would fit with the fact that sometimes present "patches" link is=
 on
> the line with pagination links, after pagination links.
>
> But this secondary navigation bar is about other views, and extra_opt=
ions
> is about modifying current view, and functions more like toggles. =A0=
OTOH
> we have such toggle for 'blame' <-> 'blame_incremental' switch in
> secondary navigation bar.

Well, at least for this particular option the toggle is closer in
concept to pagination (which also modifies the 'current' view, in a
way).

> Also this would mean that each view type would have to handle extra_o=
ptions
> itself, as secondary navigation bar is very much action-specific. =A0=
Not
> that it matters now, with only single '--no-merges' option supported.

Even with more options, I have half an idea on how to refactor this
handling in a way that should make it easy for views to handle the
extra options.

>> =A0 =A0 + on mouseover for the table section that refers to the (sho=
rt)log;
>> =A0 =A0 =A0 this would make it possible to put it summary view too, =
for example
>
> This would mean having link inside link, as those headers in summary =
view
> functions as link to 'shortlog' view (quite useful I think), and to t=
he
> project summary in the 'shortlog' view itself (I'm not sure how usefu=
l
> that is). =A0We already have problems with ref markers being links in=
side
> links and having broken layout in some strict XHTML conformance brows=
ers.

(I still think that prohibiting link-in-link is idiotic, but this is
not the place where this should be discussed)

> In short: I am not sure what would be the best solution. =A0Neverthel=
ess
> I think that link should be more visible, and perhaps more toggle-lik=
e.

I'll see if I can cook something up.

>> =A0* if you toggle merge view when not on the first page, the refere=
nce
>> =A0 =A0(first) commit in the view is likely to change drastically, w=
hich
>> =A0 =A0causes confusion. I have not found a satisfactory solution fo=
r this,
>> =A0 =A0since the obvious way to 'lock' the view (start paginating fr=
om the
>> =A0 =A0current top commit) prevents prev/next navigation
>
> Alternate solution would be to clean page (start from 0th page) when
> changing to '--no-merges'.
>
> You would probably need something like 'skip' option, with number of
> commits, not number of pages to skip, and/or 'skip_to' which takes
> commit-id. =A0But i have not thought about this much...

IIRC the log code uses pagination the way it is now because that
reflects the git log works. This would make a different approach more
time consuming on the script part.

>> +
>> +*:hover > span.merge_toggle a { visibility:visible }
>
> I'd rather not have this rule to have different style, i.e. not all
> in single line. =A0Unless it is for RFC only...

I can make it more like the others.

>> + =A0 =A0 my $can_have_merges =3D grep(/^$action$/, @{$allowed_optio=
ns{'--no-merges'}});
>> + =A0 =A0 my $has_merges =3D !grep(/^--no-merges$/, @extra_options);
>> +
>
> Wouldn't it be better to use straight
>
> =A0+ =A0 =A0 =A0my $no_merges =3D grep(/^--no-merges$/, @extra_option=
s);
>
> Because $has_merges is true also for example for 'tree' view... which
> absolutely doesn't make any sense whatsoever.

The reason why I have two vars is that one checks if we care about the
option, and the other is to see if it's enabled or not. We don't want
the 'show merges' toggle to appear in view which don't handle the
--no-merge option.

> In more generic solution (which could be perhaps put in a separate co=
mmit)
> it could be:
>
> =A0+ =A0 =A0 my %extra_options =3D map { $_ =3D> 0 } keys %$allowed_o=
ptions;
> =A0+ =A0 =A0 $extra_options{$_} =3D 1 foreach @extra_options;
>
> which means that %extra_options is hash which keys are allowed option=
s,
> and which has true value for allowed option which is actually used.

I like this approach. It's also easier to extend to other options, if
and when we'll have them.

I'll try to roll out a new patch with a cleaner design and taking your
suggestions into considerations

--=20
Giuseppe "Oblomov" Bilotta
