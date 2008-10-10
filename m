From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Really remove a file ?
Date: Fri, 10 Oct 2008 16:32:49 +0200
Message-ID: <20081010143249.GE3671@atjola.homenet>
References: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com> <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com> <d4bc1a2a0810091643u3903a1f4h44d3579b98fe6922@mail.gmail.com> <8CAF8D313562BEE-1588-259E@webmail-da15.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: marcreddist@aim.com
X-From: git-owner@vger.kernel.org Fri Oct 10 16:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoJ45-00063S-H1
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbYJJOcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2008 10:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbYJJOcx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:32:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:45458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756934AbYJJOcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 10:32:52 -0400
Received: (qmail invoked by alias); 10 Oct 2008 14:32:49 -0000
Received: from i577B8FB1.versanet.de (EHLO atjola.local) [87.123.143.177]
  by mail.gmx.net (mp064) with SMTP; 10 Oct 2008 16:32:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18jcjgqZN0jGlXnelniEx9ECdj+BaNGpFYpCSVvZv
	HJBbcLAKkOhT7+
Content-Disposition: inline
In-Reply-To: <8CAF8D313562BEE-1588-259E@webmail-da15.sysops.aol.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97936>

On 2008.10.10 05:38:25 -0400, marcreddist@aim.com wrote:
>> You'll probably also want to run "git gc" on your repo to actually
>> get rid of the huge object that was added (or does filter-branch do
>> this automatically?).
>
> I'm not sure it's required by git-filter-branch alone. In this case :
>
> git-gc saves almost 5% after the file deletion
>
> it saves 4.5% before the file deletion
>
> If I run git gc before and after the git filter-branch, it saves 4.5%=
 =20
> and then 0.2%.

Did you clear the refs/original namespace and your reflogs? Otherwise,
the huge object is most likely still referenced and thus won't get
pruned. Also, I usually prefer "git repack -adf" over "git gc" in such
situations, but that's probably just because I don't know the right
way to force "git gc" to immediately prune stuff just once.

But don't do the pruning until you're absolutely sure that you don't
require the old stuff anymore.

Bj=F6rn
