From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git rebase bug?
Date: Wed, 07 Jul 2010 14:44:50 -0700 (PDT)
Message-ID: <m3bpajm0gw.fsf@localhost.localdomain>
References: <20100707150545.GA24814@glandium.org>
	<20100707180004.GA3165@atjola.homenet>
	<20100707205126.GA11240@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-14?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 23:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcQY-0003sb-7W
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666Ab0GGVox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 17:44:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50196 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667Ab0GGVow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 17:44:52 -0400
Received: by fxm14 with SMTP id 14so55272fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=z4Me8Q+JNFgm+CC9CY2CGLGvt7hFhPYTRaRw12hm65s=;
        b=l/4FhJ1yhE8oHUEbq6KoIvhyrwNJI3IOogbxHf6uMV/+RfqNQ8hxENyCCxaLV1HCT0
         zLkgB5iPUwW3tx8/RRYyNA5inFRqJFvWS3+/SXl8RbRNQAhfoN361acejQC0oZ16cEtK
         24nrbhZsvOwFABFxjHgUnMad/TCBzeNhDzVf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=k+4+w/ypcJtrZa9g2ixuAOs4qAoVvwYAOWe+cWOoWyMFedH6q2AUle9jpADw0Vv1kw
         f7K/myZCY63geza5GtXnMsc9sZZyZWJcdCAyGd1FAfvLFbRs/6IwyFY1BSnG2gRZNH1r
         +CEt6QifnD/NWZn95AczZBEwYqs8JoYCExZgg=
Received: by 10.86.70.2 with SMTP id s2mr5465226fga.19.1278539090541;
        Wed, 07 Jul 2010 14:44:50 -0700 (PDT)
Received: from localhost.localdomain (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id 17sm15353367fau.45.2010.07.07.14.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 14:44:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o67LiG61002661;
	Wed, 7 Jul 2010 23:44:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o67Li0oB002656;
	Wed, 7 Jul 2010 23:44:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100707205126.GA11240@glandium.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150513>

Mike Hommey <mh@glandium.org> writes:
> On Wed, Jul 07, 2010 at 08:00:04PM +0200, Bj=F6rn Steinbrink <B.Stein=
brink@gmx.de> wrote:
> > On 2010.07.07 17:05:45 +0200, Mike Hommey wrote:

> > > See how the security/manager/ssl/public/nsIBadCertListener.idl fi=
le that
> > > was created by the original patch is created as
> > > xulrunner/examples/simple/content/contents.rdf.
> >=20
> > The "problem" is that nsIBadCertListener.idl wasn't actually create=
d by
> > the cherry-picked commit, but was modified. It was an empty file be=
fore,
> > created in 4292283190983fa91b875e22664a79a3aa9ea45d.
> >=20
> > And as nsIBadCertListener.idl is missing from the xulrunner/2.0 bra=
nch,
> > git does the usual rename detection, finding another empty file and=
 ends
> > up patching that one instead.
>=20
> Oh, makes sense. Thanks. So that's a quite troubling corner case...
> I wonder if empty files shouldn't be special cased...

Well, similarity score (of contents and of filename) is weighted by
contents length, but perhaps empty files / zero length somehow fall
out as an edge case...

I agree that empty files should be special cased... unless filename is
_very_ similar.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
