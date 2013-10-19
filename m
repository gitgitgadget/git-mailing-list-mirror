From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 13:55:45 +0200
Message-ID: <20131019115545.GU13967@paksenarrion.iveqy.com>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
 <20131019111137.GT13967@paksenarrion.iveqy.com>
 <CADgy817rrg0s9icaT_QdAWGiRsb6T5eg4LJAc+Q7CdM=Csexkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Ain Valtin <ain.valtin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 13:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXV9A-00071G-Dd
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 13:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3JSL41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Oct 2013 07:56:27 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50797 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab3JSL40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 07:56:26 -0400
Received: by mail-lb0-f169.google.com with SMTP id o14so47498lbi.0
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GJSoerpU0StgzFu7Jm9/T6TSDIK1LlQmHv4YSm8rbb8=;
        b=QRDxU8NNoNyoodlMqNlM/pH4ljkmQEnRij9MYNju6Hnbks6oCJ60uc5j8gYGSqMePC
         jC/GyNU7rLjCZKcL0xrjkhNCXUu/EQnMMmY+gOlCX1Hw34YcQDEwfRMaV6WYcpZVoDYQ
         M3vo7v1jtSaRHJntJGu0dGVGgIEClqECYyuXHSAV/gPs1ZYNurNNAo7FESYVv45k64Nu
         9nppNH5/DMW0gpymKXLfMm1ecVW/KBoNGt3ANC7Q8FRfYWL5lP3nRrFHKuIz3u/gk8IK
         ee+JgdQMPY0VARs1Y5IWFlJhy+MOkHQFaO3CkOznbbANV0CjPbglYN/3lH5oBlUsDXma
         g0Qw==
X-Received: by 10.112.64.36 with SMTP id l4mr5722204lbs.15.1382183785031;
        Sat, 19 Oct 2013 04:56:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id kx1sm6096873lac.7.2013.10.19.04.56.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 04:56:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VXV8D-0005KG-LJ; Sat, 19 Oct 2013 13:55:45 +0200
Content-Disposition: inline
In-Reply-To: <CADgy817rrg0s9icaT_QdAWGiRsb6T5eg4LJAc+Q7CdM=Csexkw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236398>

On Sat, Oct 19, 2013 at 02:45:46PM +0300, Ain Valtin wrote:
> On Sat, Oct 19, 2013 at 2:11 PM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> >
> > Git has a bad history with mapped drives in windows. It's also usua=
lly a
> > bad idea to use git over the network (and most mapped drives are ov=
er
> > the network and not local between virt. machines).
> >
> > I would advise not to use this setup since for the past two years t=
hat
> > git has sometime worked and sometimes not with this setup. (It's no=
t
> > just seperate git dir, a git dir at all over a smb share have been
> > problematic).
>=20
> That's a shame :(
> As I wrote I want to use git in a virtual machine and as a extra
> precaution it would be nice to have the repo outside of the VM, on th=
e
> host drive - should the VM not to start up for whatever reason I
> wouldn't lose my repo with it...
>=20
>=20
> ain

A better way (if you can afford it) is to have a repo on the virtual
machine and push to a repo on your hostmachine (so that you've two
repos). However your solution "should" work but I personally have had
some problems with that area.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
