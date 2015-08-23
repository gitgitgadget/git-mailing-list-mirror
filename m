From: =?UTF-8?Q?J=C4=81nis_Ruk=C5=A1=C4=81ns?= <janis.ruksans@gmail.com>
Subject: Re: Submodule, subtree, or something else?
Date: Sun, 23 Aug 2015 17:11:06 +0300
Message-ID: <1440339066.32140.17.camel@gmail.com>
References: <1440197262.23145.191.camel@gmail.com>
	 <CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 16:11:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTVzQ-00017F-In
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 16:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbHWOLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 10:11:11 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36109 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbbHWOLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 10:11:10 -0400
Received: by labjy4 with SMTP id jy4so14178414lab.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=pSfhEuK3ochFmDm9DOjT0cZtaDtOwv8hGrGFXNRLCW4=;
        b=IAD6Z8SvPyCc/5gBNuiMyKzQVS83IPU7vDBqUAPyIXKul7EB3lYgm+sQFAHNTYn/MQ
         +bIJoBLOIemGygtl/FvAc9MGVJ8Qhuyx6/Gei9h4JeZhW0226SQvl9CjGGJx2VHW685+
         qPZ8n/l38umzHYt/BEtcZ9Wc02XZi6nzvzv9J7LVKxLj8tM1MOl519egu9YKBwhcQerG
         /3TerB8IkFaMRTCgrf34C3apJorfZx8cwu15yN7CrA2lTKLtOPjVjYJbiDDLl6ZGSFO6
         +8495/BwLgAmXUvidb57JCTeX3s39BdODPQ4HdTFDCxqm4xkPPPFurW/fyp77u0yVmMa
         50PQ==
X-Received: by 10.152.22.99 with SMTP id c3mr16416905laf.32.1440339068508;
        Sun, 23 Aug 2015 07:11:08 -0700 (PDT)
Received: from ganja ([46.109.200.48])
        by smtp.googlemail.com with ESMTPSA id kb5sm4199470lbc.16.2015.08.23.07.11.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 07:11:07 -0700 (PDT)
In-Reply-To: <CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
X-Mailer: Evolution 3.12.11 (3.12.11-1.fc21) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276408>

On Pk, 2015-08-21 at 17:07 -0700, Stefan Beller wrote:
> On Fri, Aug 21, 2015 at 3:47 PM, J=C4=81nis Ruk=C5=A1=C4=81ns <janis.=
ruksans@gmail.com> wrote:
> >=20
> > A major drawback of submodules in my opinion is the
> > inability to make a full clone from an existing one without having
> > access to the central repository, which is something I have to do f=
rom
> > time to time.
>=20
> Can you elaborate on that a bit more?
> git clone --recurse-submodules should do that no matter which remote
> you contact?

I mean that if I have cloned a repository with submodules, cloning that
repository with --recurse-submodules will either access the "central
server" if absolute URLs are used, or requires additional clones for
each submodule.  For example

git clone --recursive http://somewhere/projectA.git
git clone --recursive file://$(pwd)/projectA projectA.tmp

The second command will cause the submodules to be downloaded again, or
expect them to be found in $(pwd).

Or am I mistaken, or doing something wrong?
