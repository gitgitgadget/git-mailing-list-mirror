From: Chris Lasell <chrisl@pixar.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 4 May 2015 15:46:35 -0700
Message-ID: <8AC0C799-2402-4AAB-8C9D-271FBF14910D@pixar.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com> <xmqqh9rsovd4.fsf@gitster.dls.corp.google.com> <xmqq4mnsottj.fsf@gitster.dls.corp.google.com> <xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:46:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpP8S-00061T-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbEDWqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 18:46:44 -0400
Received: from smtp-lb.pixar.com ([138.72.247.109]:47621 "EHLO
	smtp-lb.pixar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbEDWqn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2015 18:46:43 -0400
DomainKey-Signature: s=emeryville; d=pixar.com; c=nofws; q=dns;
  h=Authentication-Results:X-PixarMID:X-PixarRecvListener:
   X-PixarRemoteIP:X-PixarMailFlowPolicy:X-IronPort-AV:
   Received:Content-Type:Mime-Version:Subject:From:
   In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
   References:To:X-Mailer;
  b=1ncUvNamlryxn9WyCI9y9tglgOZ8KYGSmQxGm/8UP9hPaqo7wSmIQ3tE
   t5uuTKcHMOB+YA8T/Hfh6VIMXFJTHDZhwnIP4HHYX4w9kdsL4oKmoXV2P
   zvuWK9fMaW+p4hYHfqcZ3nDx8NBEwf3MfR6B8DNKz/hT/MU9h4lG1J0Qi
   TEsOadQo+gbT6horwjnfwxQFUTr/2dOLr8yiUYZj2P7ZWM6gXn+aocZAp
   +STYXwqBCVrtzMGtPRzHBFTE6DNBF4WJafbloTGw4NBpmJy+MgzJCHG0A
   JxlAcMwpA21ge/jaB+l2YuCquvdDuO69s2NLOnXsLdvjlhtmYhAlGSmm/
   Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=pixar.com; i=@pixar.com; q=dns/txt; s=dkimdefault;
  t=1430779603; x=1462315603;
  h=mime-version:subject:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to;
  bh=7qorWPojoqjvN6SLisFRt3evcTPIonu2NtMK8YFU8qg=;
  b=W+a9jj4P7xX8JuVifhMnaoit+7RNetg6Ie/1VHNNJvUjbJjYvW7LlgOK
   GGiZoC4PBmjS0BfbMJxriRNFcyUdswUG/PZn5cQYNK8IxoVG5+9Z0+Wu3
   mArwvTCKkyts01ymkra2vqq1XY66WLBoQR2Xv66JcZ+JG5yEsvvs/kTdO
   ewVz+2cBvQilDXq6woGgHOk5y4LfBNYMIg90b8Lhmb+mKyjLXLlNVuKr8
   smgsSyOP9Uyt0X87s1pENKVIxYj4FmKOrlGTFXn2CyRFrRzjbuacKeuml
   70cNds7zk4M9Uovx3HyecdCFim0U0+mTtdaxVKbXIFZNeK68rDg+I/k3u
   w==;
Authentication-Results: smtp-lb.pixar.com; dkim=neutral (message not signed) header.i=none
X-PixarMID: 32495034
X-PixarRecvListener: OutBoundAuth
X-PixarRemoteIP: 138.72.244.133
X-PixarMailFlowPolicy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.13,368,1427785200"; 
   d="scan'208";a="32495034"
Received: from unknown (HELO [138.72.244.133]) ([138.72.244.133])
  by smtp-lb.pixar.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 May 2015 15:46:36 -0700
In-Reply-To: <xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268370>


> On May 4, 2015, at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> So, use_shell=3D=3Dtrue codepath grabs that array with "editor", "pat=
h"
> and turns it into an equivalent to
>=20
> 	sh -c "$EDITOR" "$path"
>=20
> when $EDITOR has a "magic" character (including whitespace) in it.
> So what git-p4 does is *not* in line with how we use the environment
> variable.
>=20
> Perhaps a single-liner patch like this would work?
>=20
> -	system([editor, template_file])
> +	system(["sh", "-c", editor, template_file])
>=20

Thanks for the input Junio!

I=E2=80=99ll try it out, but leave the decision about patching  for the=
 maintainers :-)

Though I do notice that their "system()" function does do shell expansi=
on if it=E2=80=99s arg is a string, but not if it=E2=80=99s a list:

def system(cmd):
    expand =3D isinstance(cmd,basestring)
    if verbose:
        sys.stderr.write("executing %s\n" % str(cmd))
    retcode =3D subprocess.call(cmd, shell=3Dexpand)
    if retcode:
        raise CalledProcessError(retcode, cmd)

and the edit_template() function is passing a list

I had thought about writing a tiny wrapper script as mentioned in that =
first link you sent, but that felt even more out of line, especially si=
nce there are many references on the net to using parameters in EDITOR =
vars, particularly with mate.

=46WIW, my user is all set now, but I=E2=80=99m happy to participate in=
 this conversation if appropriate :-)

Cheers,
-Chris
