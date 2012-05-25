From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 10:31:24 -0700
Message-ID: <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri May 25 19:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyMg-0008Ix-TW
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab2EYRbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 13:31:46 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37169 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab2EYRbp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 13:31:45 -0400
Received: by qcro28 with SMTP id o28so669688qcr.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/89alsyrrSIJ6bAbkWwk143kYk1IgNVfXBLsanlcPTU=;
        b=n80VNquiQQLn9kyBZudzK9ANw372HllTFRsP8+l6tmqtcuFRV+472vfjVjsiJJ59jP
         XXwst6YNdsrySMqqq2p+HzU5ShvaCN8k8HZ9oZ8MEfD+cSvQZh09eG6k9As/1AEsfh08
         YJJnFIKP3pc6vh75LFTAGuEcJZJogcqnLVIrWwRgYyMw+5VSLbR8py8NG7hVyaAN78F4
         6XqeswgXbiBB2o3jVv+OaObpT+1BF+/J/Fzluk9Zb+qi9aeC6eG++3AkjxGjtnfxWcc5
         WgDKkWTfM1qqOMG8PfXS0ou+ho/coPN5j+1/deVaLNxATa0/5I3tmbYACcQn7zDUl8Eg
         VoMA==
Received: by 10.224.72.204 with SMTP id n12mr15706372qaj.89.1337967104884;
 Fri, 25 May 2012 10:31:44 -0700 (PDT)
Received: by 10.229.17.136 with HTTP; Fri, 25 May 2012 10:31:24 -0700 (PDT)
In-Reply-To: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198489>

On 25 May 2012 09:15,  <nguyenhu@minatec.inpg.fr> wrote:
> Hello,
>
> As you know, git stores its configuration in ~/.gitconfig file and in=
 other
> hidden files at the root of the user's directory.
>
> We would like to have a configuration directory instead of all these
> configuration files by following the XDG specification because:
> - not a lot of hidden files at the root, so better view
> - one directory per software in ~/.config
>
> We would like to give to users the possibility to store configuration=
 in
> ~/.config/git/config file.

This is, of course, highly OS dependent. Ironically, I'd say we need a
setting in .gitconfig for it. :-)

There is also /etc(/default|/sysconfig|)/git/config to consider
(perhaps for some settings that should be the same for everyone).
Better yet, it would be nice if at least some settings could be part
of the repository itself (whitespace handling e.g.).

> git would store its configuration in ~/.config/git/config file if:
> - this file exists,
> - and ~/.gitconfig file doesn't.
> Otherwise git would store its configuration in ~/.gitconfig as usual.
>
> If you don't create ~/.config/git/config, there is no change.
>
> What do you think about it ?
>
> I will send you a patch today.
>
> Thanks,
>
> Lucien KONG,
> Valentin DUPERRAY,
> Huynh Khoi Nguyen NGUYEN,
> Thomas NGUY,
> Franck JONAS
>
> Grenoble INP ENSIMAG
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
