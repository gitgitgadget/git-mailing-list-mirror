From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: error from 'git push' on v1.7.8-rc0
Date: Thu, 3 Nov 2011 17:26:58 +0000 (UTC)
Message-ID: <loom.20111103T182501-714@post.gmane.org>
References: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com> <CAJzBP5Q1LaUBL_wHFfaY-cLatd_=oez9j+=60z3kxwg_47GN_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 18:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM14V-0005Iz-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 18:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab1KCR1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 13:27:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:46031 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932781Ab1KCR1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 13:27:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RM14O-0005D4-Mt
	for git@vger.kernel.org; Thu, 03 Nov 2011 18:27:16 +0100
Received: from dslc-082-083-197-091.pools.arcor-ip.net ([82.83.197.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 18:27:16 +0100
Received: from stefan.naewe by dslc-082-083-197-091.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 18:27:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.197.91 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184730>

Stefan N=C3=A4we <stefan.naewe <at> gmail.com> writes:

>=20
> On Thu, Nov 3, 2011 at 12:43 PM, Stefan N=C3=A4we <stefan.naewe <at> =
gmail.com>=20
wrote:
> > I get errors from git push when trying to delete a (remote) branch:
> >
> > $ ./bin-wrappers/git versiongit version 1.7.8.rc0
> > $ ./bin-wrappers/git push -q . :refs/heads/nogofatal: bad object
> $ ./bin-wrappers/git push -q . :refs/heads/nogo
>=20
> (re-wrapped)
>=20
> $ ./bin-wrappers/git push -q . :refs/heads/nogo
> fatal: bad object 0000000000000000000000000000000000000000
> fatal: bad object 0000000000000000000000000000000000000000
> remote: warning: Allowing deletion of corrupt ref.

I think the problem lies actually in 'rev-list':


$ git rev-list --verify-objects 000000000000000000000000000000000000000=
0 \
   --not --all
fatal: bad object 0000000000000000000000000000000000000000


Regards,
  Stefan
