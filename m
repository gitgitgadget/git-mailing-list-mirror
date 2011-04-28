From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 11:25:50 +0200
Message-ID: <4DB9329E.7000703@op5.se>
References: <4DB80747.8080401@op5.se>	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>	<4DB82D90.6060200@op5.se>	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>	<20110427194233.GA16717@gnu.kitenet.net>	<7vwrif5q93.fsf@alter.siamese.dyndns.org>	<20110427220748.GA19578@elie>	<7vsjt35l84.fsf@alter.siamese.dyndns.org>	<20110427234224.GA26854@elie>	<7viptz5j82.fsf@alter.siamese.dyndns.org>	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com> <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:26:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNU4-0001Ma-SS
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab1D1JZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:25:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63920 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab1D1JZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:25:58 -0400
Received: by bwz15 with SMTP id 15so2127008bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:25:57 -0700 (PDT)
Received: by 10.204.81.224 with SMTP id y32mr860456bkk.152.1303982755314;
        Thu, 28 Apr 2011 02:25:55 -0700 (PDT)
Received: from vix.int.op5.se (m83-186-240-35.cust.tele2.se [83.186.240.35])
        by mx.google.com with ESMTPS id q25sm895428bkk.22.2011.04.28.02.25.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 02:25:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172330>

On 04/28/2011 04:49 AM, Jon Seymour wrote:
> On Thu, Apr 28, 2011 at 12:15 PM, Jon Seymour<jon.seymour@gmail.com>  wrote:
>> Then a command like:
>>
>>     git install gitwork
>>
>> would trivially work across all distributions precisely because the
>> distribution has provided the implementation of the git install
>> interface contract that git-core has helpfully mandated.
>>
> 
> Or better yet, git-core could provide a trivial git install
> implementation that selects between different distribution manager
> supplied plugins selected according to some heuristic, allowing
> several distribution managers to happily manage plugins in the same
> git instance.
> 
> I have to ask.
> 
> Is such an architecture really "absolutely horrid"? Is it  "crap"? Really?
> 

Yes, because it forces all distributions to name their extensions
the same and it forces all distributions to carry the same extensions.
It also makes it impossible to support 3rd party extensions that core
git doesn't know about and that aren't already packaged, unless you
want the "git install" command to have knowledge about all package
management systems and *very, very good* heuristics when guessing what
a particular extension is called on that system.

What will happen though is that the distributions will happily ignore
that and the "git install" command will fail for some extensions on
some distributions.

Besides that, it forces users to install git from their distribution
packages so we're hard-shafting the git developers who usually have
at least some installations done from source.

We just went far beyond "absolutely horrid" and into the realms of
"steaming pile of abominably manure-like ideas whose inventor should
be slapped silly for their own good".

So let's get back to the basic wish you have here. You want people
to be able to easily find, download and install "git work" so that it
works nicely with man-pages and all.

The wiki-page with known extensions and the patch to core git so that
"make install" can put man-pages in the right directory are the first,
simplest and smallest steps that takes us the farthest towards that
wish without burdening people you have no control over with more labor.
In short; It's both good engineering and polite to implement that and
then consider what new possibilities open up and see what people do
with those possibilities. You might be surprised.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
