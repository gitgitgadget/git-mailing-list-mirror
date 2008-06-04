From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 10:30:08 +0200
Message-ID: <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
	 <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
	 <m3mym1zkus.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3oOj-0007zA-Qf
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbYFDIaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYFDIaQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:30:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:64623 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYFDIaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:30:15 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2033156rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bU0oyXpaaGmu3OxmXAorFJEHHGzRgdckUOZ23Oo19Lo=;
        b=HKlw7VV997nFzQzlv3BD2cMW3oOe0q2Js+dmqs3+XwKPR/v+POYKd+OLOgVWuPl+YN6mBjqaU/Qk+xRmnS5sHKwLatuaYYbfNHQWSX7J0Wa/tKuz9dQVknYXtWJdQT5URM1SKPmVLs8+yn+IqJ5KveG9pIpnEbTOGGziMWmWq00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=yC8uSQ9yYM3G6FomKRRAt3l9M9NJWO+89r+gDkDo4QdBHa2saEtoBE5u+xEQ+JWHnGOA5n2Q373FhM71sPXM4BnTxZzOk6hVIyhsELHb86vfNhNIj4tW3EL+U6t19YraXLvgkR/a216qCN47IKCMrLw3Q71Gpt9loh86UBjS/w0=
Received: by 10.141.162.5 with SMTP id p5mr6448025rvo.221.1212568214048;
        Wed, 04 Jun 2008 01:30:14 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 01:30:08 -0700 (PDT)
In-Reply-To: <m3mym1zkus.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83762>

On Wed, Jun 4, 2008 at 10:05 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> David <wizzardx@gmail.com> writes:
>
> [Please don't remove quote attributions]
>

Thanks for the netiquette tip, I didn't know this was a bad thing. Are
<snip>s also a good thing, or is it ok to just cut out the parts that
don't need re-quoting?


>
>  # make temporary branch to not move to-be-copied during rebase
>  $ git checkout -b tmp-rebase to-be-copied
>  # copy commits; results are in just created temporary branch
>  $ git rebase --onto branch copy-from tmp-rebase
>  # check if everything is all right and rename temporary branch
>  # to final name
>  $ git branch -M tmp-rebase branch
>

Thanks :-) This still isn't what I had in mind (see my earlier post
with examples), but I realise now, thanks to your post, that I can
probably do it like this:

1) Make a temporary branch off the topic

2) Rebase the temporary branch onto master interactively (maybe or
maybe not with --onto), and in interactive mode take out, reorder,
etc.

3) Check & test the temporary branch

4) Merge the temporary branch into master, and drop the temporary branch.

5) Rebase the original topic branch onto the new master.

Thanks to all the posters for their tips.

David.
