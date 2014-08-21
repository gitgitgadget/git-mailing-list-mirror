From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Relative submodule URLs
Date: Thu, 21 Aug 2014 14:37:05 +0200
Message-ID: <20140821123705.GA68456@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <20140819102421.GA5012@book.hvoigt.net>
 <CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
 <xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
 <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
 <20140819193010.GA64203@book.hvoigt.net>
 <CAHd499BvBBymACfHVZyuSXuNSFbT+M8my4uATOsn30w90Zb0QQ@mail.gmail.com>
 <20140819205747.GB64203@book.hvoigt.net>
 <CAHd499C2F2s51qmfwS5VxLvP-O2Wjdb6-yfj+T9tMkZz7ohVXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKRcV-0000UG-24
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 14:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbaHUMh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 08:37:29 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:37756 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbaHUMh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 08:37:27 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XKRc5-0007rz-EU; Thu, 21 Aug 2014 14:37:09 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499C2F2s51qmfwS5VxLvP-O2Wjdb6-yfj+T9tMkZz7ohVXQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255609>

On Wed, Aug 20, 2014 at 08:18:12AM -0500, Robert Dailey wrote:
> On Tue, Aug 19, 2014 at 3:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > I would actually error out when specified in already cloned state.
> > Because otherwise the user might expect the remote to be updated.
> >
> > Since we are currently busy implementing recursive fetch and checkout I have
> > added that to our ideas list[1] so we do not forget about it.
> >
> > In the meantime you can either use the branch.<name>.remote
> > configuration to define a remote to use or just use 'origin'.
> >
> > Cheers Heiko
> >
> > [1] https://github.com/jlehmann/git-submod-enhancements/wiki#add-with-remote--switch-to-submodule-update
> 
> Thanks Heiko.
> 
> I would offer to help implement this for you, if you find it to be a
> good idea, but I've never done git development before and based on
> what I've seen it seems like you need to know at least 2-3 languages
> to contribute: bash, perl, C++. I know C++ & Python but I don't know
> perl or bash scripting language.
> 
> What would it take to help you guys out? It's easy to complain & file
> bugs but as a developer I feel like I should offer more, if it suits
> you.

For this particular case shell scripting should be sufficient. And it
should not take too much time. Have a look at the git-submodule.sh
script in the repository. That is the one implementing the git submodule
command.

Additionally you need to extend the documentation and write a test or
two. Writing a test is also done in shell script. The documentation[1] is
in asciidoc which is pretty self explanatory.

The test should probably go into t/t7406-submodule-update.sh and, as
Phil pointed out, in t7403-submodule-sync.sh).

Also make sure to read the shell scripting part in
Documentation/CodingGuidelines and as a general rule: Keep close to the
style you find in the file. And when you are ready to send a patch:
Documentation/SubmittingPatches.

If you are happy but unsure about anything just send a patch with your
implementation (CC me and everyone involved) and we will discuss it here
on the list.

Cheers Heiko

[1] Documentation/git-submodule.txt
