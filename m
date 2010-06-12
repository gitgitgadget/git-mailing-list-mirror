From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Sat, 12 Jun 2010 12:26:05 -0500
Message-ID: <20100612172605.GA6132@burratino>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605025702.GA2019@progeny.tock>
 <AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
 <20100605033626.GA2252@progeny.tock>
 <AANLkTimHZdT3vfuUyG1cnanE3WLrhDGqqw5JyYfza6wD@mail.gmail.com>
 <20100605192717.GB5273@progeny.tock>
 <AANLkTimeaQeCoGREwwaOdaW6c9WTUNZF9oLfNZy7DVo3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 19:26:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONUTN-0000w6-N7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 19:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab0FLR0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 13:26:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64213 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0FLR0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 13:26:14 -0400
Received: by iwn9 with SMTP id 9so1629721iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C+6Hg1p2hay2Py89cM5bJZ+GOYMsiD6s139/Hs+HJSw=;
        b=IJcr62jOepIMmN16sTh/9E5ULIL2zfL6tLyfKROt4hmZfi4JIDeRGwt63vhsQznx3p
         uXmBExkIw1z3KMvKINYWD+WKUxkWoLlHXrrawjseWBMSWhEgPyLOv1mvjoPFxpQKGfil
         QWX3PkhLEHufl6MUm91E+eXMB3sxxTPtagbQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UWvjkI2RVimnMIt8wA/6Tmx49h6tqNpp97c+WtKAINjmvjSl+Jq/m2y4z16rFr28ct
         M5dPJseKDLf/CoT/xGfa6JdFQH9KoiJovvSCDZaYcfoLcZQgzbflE7ZpK+kroWLYmslU
         QazH3oPUNU592xvwVspN+riTxG30TBJSJ4BBc=
Received: by 10.231.168.135 with SMTP id u7mr3683757iby.125.1276363573278;
        Sat, 12 Jun 2010 10:26:13 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm11293528ibf.13.2010.06.12.10.26.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 10:26:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimeaQeCoGREwwaOdaW6c9WTUNZF9oLfNZy7DVo3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149025>

Hi =C6var,

Sorry for the long delay in replying.

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> I didn't see a reason not to enable it by default.

I only meant that if it is very useful but the kinks not ironed out,
releasing with the feature disabled by default is a way to cope.
An even better way is to get experience with the feature in next or
pu until it is ready to be shipped enabled by default, so you can
forget I said anything. :)

> But since the semantics of Git will be the same unless users
> explicitly request translations (by setting the LC_* variables in
> their OS)=20

Sometimes I am on machines with LANG set to fr_FR.UTF-8.  If plumbing
is going to be giving _all_ its other messages in English, I would
rather it give the system call errors in English, too.  But this is
not a strong preference, and it is possible we would want to let all
messages to stderr be translated, making this moot.

Thanks for the explanations.
Jonathan
