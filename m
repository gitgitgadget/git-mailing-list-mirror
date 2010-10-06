From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: cvs importing a forked project
Date: Wed, 6 Oct 2010 10:51:01 -0400
Message-ID: <AANLkTimawPYmqoH_tupOc6zsgSeTU=dqgXA9pB95m542@mail.gmail.com>
References: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
	<Ci4laGuWQaUrmZdwH9nojZ77bfNScQVKlCGXCSR6hP816oyKCfkncQ@cipher.nrlssc.navy.mil>
	<AANLkTi=DRWeJc5gW0Rio9NZh5a02FQtdd9TeEzOkBimr@mail.gmail.com>
	<AANLkTimnvAXAiE=03E3VdXSeP3pQBa8UTH548vEWsYsG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 16:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3VKp-0003Ql-QL
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 16:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab0JFOvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 10:51:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37339 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440Ab0JFOvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 10:51:04 -0400
Received: by wyb28 with SMTP id 28so7264066wyb.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dyax58ZA7ToyLjZ1M/OGSm5iB5OAFtQhcZxP9hOgG7E=;
        b=Zkq2EiTQJfRcfRkULFPwHiM90BUNneNyD9S8POjnD2Oxgd5HXRiQsSOHhV2OXpxVbT
         rmOLxaO7URHaASGN8GfoLNRxZQZv+QtNC4Ix27Pjl8T3kjiq8JTutF0I/a3kJPR3K9w9
         2l2jsqU70N97zx6pYft1v4M8kAF3RBZhyQbCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RPwVve1dOxnHLF0jU8H5rvd17bxPKHhCgSDqOvWl8bOqJ7SpvVRfyfBwKt7+HfxY7m
         cVNCfdi4BJLaFbb7Pz5QGTb7lK192n4EC1jI2DprLs31NjsT/fjXmgmmVuX4IYM30b59
         eclfXq1kPW42LiSwwDOqnkTw2yU61+VWInfFE=
Received: by 10.227.157.200 with SMTP id c8mr11317818wbx.69.1286376661980;
 Wed, 06 Oct 2010 07:51:01 -0700 (PDT)
Received: by 10.216.80.144 with HTTP; Wed, 6 Oct 2010 07:51:01 -0700 (PDT)
In-Reply-To: <AANLkTimnvAXAiE=03E3VdXSeP3pQBa8UTH548vEWsYsG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158291>

Thanks a bunch.
That set of commands seemed to work except the "git remote add"
commands needed a name.
After doing that I saw both disconnected trees in gitk.  I created my
=2Egit/info/grafts file and it looked good.
I removed the two remotes afterwards and had to manually create a maste=
r branch.

I wanted to try to "switch to a new parentless branch" but don't know h=
ow.
How can I create / switch to a new empty parentless branch?


On Tue, Oct 5, 2010 at 3:20 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Oct 5, 2010 at 18:38, Eric Frederich <eric.frederich@gmail.co=
m> wrote:
>> Interesting. =A0Looks easy to use except I can't figure out how to g=
et
>> the two projects imported to the same git project.
>>
>> If I run the following...
>>
>> $ git cvsimport -C myproject -d /some/vault projects/foo_old
>> $ git cvsimport -C myproject -d /some/vault projects/foo_new
>
> Either switch to a new parentless branch between the two (I don't kno=
w
> cvsimport), or import them in two distinct git repositories. Then whe=
n
> that's finished do:
>
> =A0 =A0git init the-merge &&
> =A0 =A0cd the-merge &&
> =A0 =A0git remote add ~/cvs-repo-1 &&
> =A0 =A0git remote add ~/cvs-repo-2 &&
> =A0 =A0git remote update
>
> And you'll have all those commits / branches / tags from both of them
> to work with.
>
