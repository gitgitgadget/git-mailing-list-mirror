From: Scott Chacon <schacon@gmail.com>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 9 Sep 2011 08:45:52 -0700
Message-ID: <CAP2yMaJ+UBHZp0U=QWOZbnbbOuq8vNoJODWtxZPb1sKXTC_UEg@mail.gmail.com>
References: <4E6A23DB.1040606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23HC-0005Al-DZ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122Ab1IIPpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:45:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61231 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1IIPpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:45:52 -0400
Received: by ywf7 with SMTP id 7so1725558ywf.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QyYzKP6ivmIFCIsSWT9DIN2tNPBzv8CILtyXzcLeNvg=;
        b=bYCrGV6wyGZrPmIUA6w1EL5XZ6IEDNYrgzAdS4u+LGbr1IwPPrbtFb1WlnS0QAVuxJ
         dzvOM96upTCepDuu/BSeTOQ4QP3nCUPF8Yg5hyu/nE5IzRXItuesoaIvVq9wex7Fe2yQ
         HkWw/7yE2oTW2jhBr7uSCM28IOXe+YNS5MkwQ=
Received: by 10.151.5.21 with SMTP id h21mr2361625ybi.438.1315583152387; Fri,
 09 Sep 2011 08:45:52 -0700 (PDT)
Received: by 10.151.154.18 with HTTP; Fri, 9 Sep 2011 08:45:52 -0700 (PDT)
In-Reply-To: <4E6A23DB.1040606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181080>

Hey,

On Fri, Sep 9, 2011 at 7:34 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> which has all the renaming (*.txt -> *.asciidoc) and Makefile and script
> changes, but is missing some include changes (because include breaks
> anyway, see below).

I can change this so we can render .asc if that's less ugly.  I've
been meaning to do this for a while, but I don't think I ever
incorporated it.

>
> Our own customisation is not loaded (of course) so that, e.g., the
> linkgit macro does not work; and the include statement makes GitHub's
> parser unhappy and choke.
>
> Does anybody feel this is worth pursuing?
>
> + Nicer blob view
> + Simpler way to judge documentation changes
> - Need to get our asciidoc config in there
> - GitHub's parser neeeds to learn include

If this is interesting to people, I can help out.  However, you can
also fix rendering issues, as long as they don't introduce security
issues (which 'include' and macros can do) by fixing it here:

https://github.com/github/markup

That is the rendering engine we use.  If you make it work how you want
and it's safe and you send us a pull request, we'll happily take fixes
to the asciidoc renderer.

Scott
