From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Error building installing on Redhat Linux Server release 5.3
 (Tikanga)
Date: Fri, 19 Mar 2010 17:57:03 -0500
Message-ID: <20100319225703.GA17058@progeny.tock>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Cox <mhcox@bluezoosoftware.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 23:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsl7P-00074P-UT
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 23:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0CSW4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 18:56:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48006 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0CSW42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 18:56:28 -0400
Received: by gwaa18 with SMTP id a18so42341gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KVo8v6FWH7DbXN0vWvYIQvCN7RFqiknkZfsw+dIcyqc=;
        b=NahHC42eVZA8HuqW10CMbsQQu+UTnPPAz81P0CsXmiGblGdyMPWHBdDRxbx2TIQmWa
         zQ+dgqT2NNmikuRzj9cOr3rSwz9JpWoKz6i4lUynE9gjH1p95AFOktNV3cyDJVajK85l
         SGcLNZcSHiEfdet+qGRtyNOS50kp4vfEEu1lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=W2LhgeaU4qpcaYIGt3vJglKUL5RmnHqwg5W77o3Xxx7xsYq1jbJUFWlk9shpZB8Elg
         Hgy56d9tZ3sJRj+Cceqs8PzL5jHy4n5YrJ+Avql1IbrTpWrCEAO3a/w3Me5Kk3F7zZx+
         jv2MnoSk+6Op42N60gVygMUPYOEoPMQLaYBxE=
Received: by 10.101.9.25 with SMTP id m25mr1932684ani.176.1269039376844;
        Fri, 19 Mar 2010 15:56:16 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5936iwn.12.2010.03.19.15.56.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 15:56:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142658>

Michael Cox wrote:

> (cd blt && gtar cf - .) | \
>         (cd '/home/e477610/exptool/share/git-core/templates' && umask=
 022 && gtar xof -)
> gtar: This does not look like a tar archive
> gtar: Skipping to next header
> gtar: Archive contains obsolescent base-64 headers
> gtar: Error exit delayed from previous errors
> make[1]: *** [install] Error 2

Your tar command seems to be seriously broken: it is producing output
that it cannot consume.

What is the output of =E2=80=9Cgtar --version=E2=80=9D?  Does this prob=
lem still occur if
you try again?  If you run the command above by hand, does it produce
the same result?

I checked https://bugzilla.redhat.com/ for known problems but did not
find anything similar.  If this problem proves reproducible, I would
suggest reporting it with them.

In the mean time, you can use git without installing it by adding
/home/e477610/exptool/share/git-core/bin-wrappers to your $PATH. :)

Hope that helps,
Jonathan
