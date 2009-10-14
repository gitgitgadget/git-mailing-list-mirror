From: Laurent Boulard <laurent.boulard@gmail.com>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Wed, 14 Oct 2009 17:59:23 +0200
Message-ID: <cdea158b0910140859y3a914654nd293557eb44067e3@mail.gmail.com>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com> 
	<loom.20091014T001602-378@post.gmane.org> <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6gd-0001oP-MT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934738AbZJNQBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933325AbZJNQBc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:01:32 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:30509 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934226AbZJNQBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 12:01:31 -0400
Received: by gv-out-0910.google.com with SMTP id r4so241132gve.37
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C6Fco/qlcREY88JCS0Akq6N89HWAiMujr8zRQLgUOow=;
        b=jy02godIiSNyKDSYPsMMbZKnucmavQXW8JOTls4cAaHl88GUXVyRQUkzDrGvKdOQEY
         q3trl5bDFv7R0x14Ug08LxTWBZw0VC1rW/uSzwuHAe/5BxJzZ2c7yCGJcXFq7ekVUxP/
         w0GMTLB3y36u9vD9MsexIEAs3+81os8RY4NxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vLNXXRAdqYBd/eRKarrZNP59Rfox1enyxSxa85QjMMLACElr5sll+KX1HH93nXqtjk
         ZxpIi7yX/WxQPLHYQMW09qggg85GvDviLYosqh3n5g6LkMRsjp5Q2RxjPq/YAhLHkEd/
         OKPBdain5DCj5hwJjeDcdtYmCpvA7q5YdQ+x4=
Received: by 10.102.226.17 with SMTP id y17mr3764811mug.67.1255535983141; Wed, 
	14 Oct 2009 08:59:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130302>

On Wed, Oct 14, 2009 at 16:03, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> See http://thread.gmane.org/gmane.comp.version-control.git/122823/fo=
cus=3D122862
>>
>> In which Junio suggests:
>> $ rm .git/index
>> $ git reset --hard
>>
>> in order to "restore sanity to your work tree"
>
> Of course this is insane as a user interface. =A0It is not even plumb=
ing.
>
> So I started some time ago to code a "git checkout --fix-crlf", but I
> am not really happy with the user interface. =A0I think that Git shou=
ld
> realize itself that something went wrong with the line endings. =A0If=
 I say
> "git reset --hard", it is just a bug in Git when it insists afterward=
s
> that the files are modified.

I have to work on win32 at work and depending of projects, I have to
play with autocrlf/crlf config.
So I cannot do a git clone because it will inherit the global crlf
configuration which is not want I want. My flow is often:

$ git init ...
$ git config core.autocrlf ...
$ git remote add origin ...
$ git fetch origin ...

I stuffed those four lines behind a few git alias but I think having a
config option for git init and git clone to set core.autocrlf in
repository would be a (small) improvement, isn't it ?

Laurent.
