From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 3 Mar 2008 20:43:56 +0100
Message-ID: <4d8e3fd30803031143n28371721jbe7eaf2f5e72dcb7@mail.gmail.com>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	 <vpqskz82bm3.fsf@bauges.imag.fr>
	 <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
	 <vpq63w325px.fsf@bauges.imag.fr>
	 <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
	 <alpine.LFD.1.00.0803031057140.2899@xanadu.home>
	 <4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com>
	 <alpine.LFD.1.00.0803031307110.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGaV-0000aZ-5g
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbYCCTn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 14:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbYCCTn7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:43:59 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:38628 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbYCCTn6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 14:43:58 -0500
Received: by wf-out-1314.google.com with SMTP id 28so315708wff.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K2gUBYvncjGHPR5qmAHFCit+cs0XP0dHpP3yeSD+Dd0=;
        b=sEmTcDu6Cvu6hlnA2dJf15EvJa3fXpzT6BaMuCRlhK5nVu0LiWlfwSL9zl8UrDN0asYGytF2kjlbZQ/Y8BlK+ZPEzpFsfcEioojI+8deC6q8mJdqsuWvZwVwIap6lohrVbfhANeVoIyKq251rIiYl6g40vaP+A6cy4jTQ4yD7G0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFqE5AKU2/ol7Rhgdor22+2gTWgt3TzcH3JFwgsKZzCCyj3dgNIYA4/36Gqoo3vXllgMwQCas1kxu2V9yN5t/GsPrPGdQdXmYfmQp+KIfet3vrTadPeOghne9jX04skE5QrrYYu4wihSRNeakKjWHalMAGy26c+gF5DTb4gEjnI=
Received: by 10.142.177.7 with SMTP id z7mr345188wfe.0.1204573436659;
        Mon, 03 Mar 2008 11:43:56 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 3 Mar 2008 11:43:56 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803031307110.2899@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75977>

On Mon, Mar 3, 2008 at 7:07 PM, Nicolas Pitre <nico@cam.org> wrote:
[...]
>  You still think in terms of "data used to update a branch".  There i=
s no
>  such direct relation between the fetched data (objects) and the upda=
ted
>  branch heads.  What you do when listing the commits found between
>  origin/master@{1} and origin/master@{0} (or simply origin/master wic=
h
>  is equivalent to origin/master@{0}) does not necessarily correspond =
to
>  the data you received during the fetch.  For example, it is possible
>  that half of those commits were already part of another branch in yo=
ur
>  repository, hence the fetch operation won't download them again.  St=
ill,
>  the origin/master branch now has acquired them all which wasn't the =
case
>  before.  To really _see_ the actually received data during a fetch
>  requires internal Git knowledge and digging in the pack directory --
>  there is no (need for any) UI for that.

Yes, this time it was me using a completely wrong terminology.
What I was looking for is what Sergei suggested.

>  > And how about a repository which have reflogs disabled?
>
>  Well, just re-enable them.  ;-)
>
>  Since they're on by default, if you turned them off then you surely =
know
>  what you're doing and why.

Oh well, very true!

Maybe it's again just me which is still not used to git fetch (or my
mental translation of =B0fetch=B0 in Italian)
but I found easier to "visualize" the commang "git remote update"
which in my setup alway means
"Fetch updates all the remotes in the repository"

Again, thank you for your comments and for your time.

Ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
