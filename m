From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Wed, 26 May 2010 10:19:42 +0200
Message-ID: <AANLkTilYb6iPHSdttCjho92Jly3vl5XH-4BM9UK36xM4@mail.gmail.com>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
	 <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
	 <4BD1B5E5.6030307@spacetec.no>
	 <Bo_XNJQjQnJja3BLqR-rv4YxKSSFpcSLegtSIJn8boisM3ilazwT7w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed May 26 10:19:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHBqE-0003wY-9H
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab0EZITr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 04:19:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49242 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab0EZITp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 04:19:45 -0400
Received: by fxm5 with SMTP id 5so4089087fxm.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MraMCNbyqspTl6e2DiRz19lTHeneqOwAbxEDT0Lses4=;
        b=quZPnvQgbhlwWGNyT+OCkmrLox17oVfhtFl1bbJs25MOwUJZSoIRPpcMRdtUfVObJL
         ngD8EpkQdM+nYQpG8HnTOgQT+djXuNWGaR4mkIhp9UvlFEAocpkagLb7Rydt6kySb9+/
         4LYU0HOFengn3ZtQUqPPZSFWTjHDzlqaQ/zyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Xm6g80bpEwWF/27KBGXe+sqPb/oO6JHhQz4KljoUbJj9IiwILJcntAyR0aZgmStlmb
         EfDg1kSAPb832Xy6klZlHJAhCZ0JuN6/Rp9B+9or2+cZysW+PpAokPiT+bvXTOxCjpiv
         P/1FDhub6hG3ZMLi7XkQS+RVmW3rRnWwUyvnY=
Received: by 10.204.47.153 with SMTP id n25mr3233510bkf.199.1274861982972; 
	Wed, 26 May 2010 01:19:42 -0700 (PDT)
Received: by 10.204.154.132 with HTTP; Wed, 26 May 2010 01:19:42 -0700 (PDT)
In-Reply-To: <Bo_XNJQjQnJja3BLqR-rv4YxKSSFpcSLegtSIJn8boisM3ilazwT7w@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: 16GkRDYLHYvyF3FZ9Issu_1VWmc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147781>

On Fri, May 21, 2010 at 22:45, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
>
> Hi Tor, I've been out of town for a few weeks...

No problem, thanks for reviewing the log.

> On 04/23/2010 09:59 AM, Tor Arntsen wrote:

>> Below is a diff between the output from a run on Linux and the Tru64=
 one
>> (instead of a full log), just to illustrate which ones failed.
>
> I skimmed through the log and it looks like the failures are mostly
> related to tar and iconv. =A0Possibly your tar is too old, or does no=
t
> support some option that git is using. =A0The iconv failures related
> to ISO8859-1 are a little strange since that encoding is very
> common. =A0Some implementations of iconv can produce a listing of the
> encodings that are supported. =A0You could check for support for ISO
> 8859-1.

I have re-run everything after installing GNU tar, and that fixed up
the tar-related problems. There's still an iconv issue, and I'm going
to look at it at some point - for now however I suspect that it might
be a local problem caused by mixing native (/usr) and local
(/usr/local) versions of iconv.

> Many of the other differences are just because some tests were skippe=
d
> on the Tru64 run that were not skipped on Linux. =A0The tests were sk=
ipped
> because some required binary was missing, like gpg or cvs.
>
> Looks like you were able to run most of the test suite which is good.

Yep, it looks pretty good (after the re-run), except for the iconv prob=
lem.

I haven't posted any update of my Tru64 Makefile patch yet, I'm
waiting to see if Gary Vaughan's portability patches are accepted -
they included a Tru64 update to the Makefile, essentially a subset of
my patch, enough to make Tru64 build with ./configure. If his patch
gets included I can send a new patch which will add the necessary
stuff to make it build also without ./configure.

-Tor
