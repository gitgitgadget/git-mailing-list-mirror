From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: integrating make and git
Date: Fri, 17 Apr 2009 21:24:51 +0400
Message-ID: <37fcd2780904171024v1b65d621q2725858e76358c36@mail.gmail.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
	 <loom.20090416T034427-809@post.gmane.org>
	 <8763h5qazf.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Apr 17 19:26:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lurpg-0002wN-DE
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 19:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939AbZDQRYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 13:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbZDQRYy
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 13:24:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:44890 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbZDQRYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 13:24:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so139622fgg.17
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gPvwmlcO+CU0bjh8oIfmmAF0+EYsk10UHWREI+CEx3k=;
        b=x5ZL5NJZijoYjUHF5nM+f9s+8KLd5wifsoyoPE6/3HJQnLPYwXXQCakbf4u0Q+FCmN
         FkckC/dlWfDCYIzq93NXfLcT05/ucSDws6WX4PStyVsi1JwHF0FtLIiyupTEZMMRG9x9
         raYuyHIdViC8/eVl07X3UeVgJ+nKQReUbWrVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I/pB8WREypSqXImM3Roy5bN1u/WogGTUV1noNjXBq6FHrTiTEhD/goHjkRLGV3N97A
         J5ZUS3LYbpPMmFRucPhYxRJD6Mv35/g3syhaB12i2f2KkprZRvBLRs0ZmF9ahNA2clOD
         IXUX3ieuP3RYr+B6U9dRoEIVvyq468bM7JG3Y=
Received: by 10.86.29.8 with SMTP id c8mr2212183fgc.7.1239989091149; Fri, 17 
	Apr 2009 10:24:51 -0700 (PDT)
In-Reply-To: <8763h5qazf.fsf@krank.kagedal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116762>

On Thu, Apr 16, 2009 at 12:05 PM, David K=E5gedal <davidk@lysator.liu.s=
e> wrote:
> Ben Jackson <ben@ben.com> writes:
>
>> E R <pc88mxer <at> gmail.com> writes:
>>
>>> Now suppose that making 'lib1' only depends on the source code in a
>>> certain directory. The idea is to associate the hash of the source
>>> directory for lib1 with its the derived files. Make can check this =
to
>>> determine if the component really needs to be rebuilt.
>>
>> ClearCase has "wink-ins" which are very much like this. =A0It knows =
that a given
>> object was produced from a certain set of sources with a particular =
command.
>> When someone wants to recreate that object (not even necessarily the=
 original
>> builder) it can "wink in" the result. =A0Typically a brand new "view=
" (a ClearCase
>> working directory) build will consist of winking in a ton of objects=
 rather than
>> building anything. =A0I'm not sure how much of this is due to clever=
ness in
>> clearmake and how much is due to the view being implemented as a vir=
tual
>> filesystem (which can see every repository file being read as part o=
f a build).
>
> It very much depends on implementing its own file system, since it
> otherwise would have no idea what the *real* build dependencies are.

Not necessary... You can use LD_PRELOAD to intercept 'open' (and all
needed syscalls), but it works only on those platforms where LD_PRELOAD
is supported.  IIRC, there was some tool that did this, but I have neve=
r
used it.  I am pretty happy with ccache :)

Dmitry
