From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: [ANN] git JSONRPC web service and matching pyjamas front-end
Date: Tue, 29 Jun 2010 23:26:36 +0000
Message-ID: <AANLkTilkowXIJYPsE-YSXdcwPv5gBCZ-dzuQTx8nhnwn@mail.gmail.com>
References: <AANLkTilIUNJkyJ60AgYSuceDfNuNCFtBFfNi9o6_oEhM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 01:26:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTkCR-00083J-W9
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 01:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0F2X0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 19:26:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35827 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0F2X0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 19:26:38 -0400
Received: by fxm14 with SMTP id 14so80070fxm.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Ll6DNRc+r9e0/tNBqphcCvyATg4vD832GoMOwMuuofs=;
        b=nARhqDWlaRG5LgZAv81DWBPVWyXd1CQFsM6WFCahEplJX4FYBYSlRWa/fSRGsp+qTa
         a1jxW5y3dap5rYG5WwPE4iRTs91dcaVJ9UsMSfSJd4SMOp4gq8eeRRp7EeNL61aQli0b
         tLjSEKJTwEvEbXLaS+bI7FNVMsbxH3TCv7fwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=np9XI9P+glOYWyHr/ay0+yY2CcXfLfZJMVGSBUkf9diexGatw4o8ippDmCkh+SgxNP
         HJSsdp3XyxLVvXv3aCaee20jrpPTdLrbaSmgogFDsz0T/8RKZode8vrdIuvMm3CY9zU6
         YWQNxJuQXkM36TnwZcpvqMvKDUOeLXfuURJh8=
Received: by 10.103.209.9 with SMTP id l9mr2977235muq.64.1277853996552; Tue, 
	29 Jun 2010 16:26:36 -0700 (PDT)
Received: by 10.103.134.20 with HTTP; Tue, 29 Jun 2010 16:26:36 -0700 (PDT)
In-Reply-To: <AANLkTilIUNJkyJ60AgYSuceDfNuNCFtBFfNi9o6_oEhM@mail.gmail.com>
X-Google-Sender-Auth: Rayh2dhsnFdLQ30s5sxDEdDAeIo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149931>

as more than just a proof-of-concept to get pyjamas out of "a nice
toy, doesn't do much, great demos, shame about real life" mode, i've
created yet another git repository browser. =C2=A0this one, thanks to
pyjamas, obviously runs as both a desktop application and also as a
web application - same source code.

pyjamasgitweb is actually two independent happily small projects. =C2=A0=
the
first is simply a JSONRPC-based git web server (in python, using
python-git) and the second is a matching front-end.

the front-end is happily bare but functional. =C2=A0a demo is here (ple=
ase
be nice to it) where you will see immediately a total lack of colour
or even borders:
http://pyjs.org/pygit

if anyone wants the source code, or to help contribute, it's at:
=C2=A0 git clone gitolite@pyjs.org:pyjamasgitweb

to start the server, read the README, install the dependencies, then do=
:

$ cd jsonservice
$ python srv.py {path to top level of repository} &
$ cd ../pyjamas
$ ./build.sh # requires symlink ~/bin/pyjsbuild to sandbox
$ firefox http://127.0.0.1:8000/outputJSONRPCService.html &
$ python JSONRPCService.py # for the desktop version

obviously, if you just want to write your own JSONRPC client, you
don't need pyjamas...

l.
