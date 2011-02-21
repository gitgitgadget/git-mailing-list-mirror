From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 18:11:44 +0800
Message-ID: <AANLkTimAE4AOCYibrCRHaSJ-mHkrQm7yZbHNy3kWGj7-@mail.gmail.com>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
	<20110221100454.GM22168@axel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Freyn <axel-freyn@gmx.de>, christian.couder@gmail.com
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSrj-0002np-O1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab1BUKTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:19:34 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:58549 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUKTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:19:34 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Feb 2011 05:19:33 EST
Received: by gwj23 with SMTP id 23so900503gwj.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SPmWe/sE0MNrjD/UB6UMViaSXP0mTTFmsEWlEOCIPYI=;
        b=QWd+0qbgsc/rpOqOk/YUnGxGZMOHFIW1g4i1Us7iZ/dVby1d2xY+LgF//9Lbw7xAIp
         szUtDFhmzNiMoavGyRi9Yy518NWR+awtrjv5e+Y1qshZsWDocj9Pk36K7P/RLSoNS++l
         L6rTrCFos1y76nn8GzSYVJEcqup0FVMpNMXaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IejObJokrAeRseW2vnmFXMflhV3pI42zO9Fo8gnpegYHTzdasX2/trqQUW3qybonEP
         K5pI1vui9MTPwSBmmk0isbEI68kMtedvOnl+y3gyI0ddSGD6e/oj9ZqyzAR8lmt9Pqji
         4QI05f/lf8TuV6JoVpb6NELQB9yqV9vubPBxQ=
Received: by 10.147.82.11 with SMTP id j11mr1846315yal.14.1298283104766; Mon,
 21 Feb 2011 02:11:44 -0800 (PST)
Received: by 10.146.168.17 with HTTP; Mon, 21 Feb 2011 02:11:44 -0800 (PST)
In-Reply-To: <20110221100454.GM22168@axel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167465>

Thanks, axel and Christian.

I am just look for a simpler method. since i have a full backup,
finally , i do something like following

git clone --bare --reference bad-repo.git foo.com:good-repo.git repo.gi=
t

On Mon, Feb 21, 2011 at 6:04 PM, Axel Freyn <axel-freyn@gmx.de> wrote:
> Hi,
> On Mon, Feb 21, 2011 at 03:50:09PM +0800, Ping Yin wrote:
>> I have a corrupted git repo, with "git fsck", it shows
>>
>> missing blob b71eb55f2dbc97dafd4a769fc61f346e69a5e0af
>> missing blob 282035f3ae964e1e288f352c370be8edd11d3078
>> missing tree 3c20f556eecc476e3542cc522d46a62a4461fec6
>> missing blob f321b578edeb452358497e832815d6cae6b36886
>> missing commit 6d23f5084c975be637f7d748db82116bf84d3872
>>
>> And i also have a good backup repo. How can i recover the corrupted
>> repo with the backup repo?
>>
>> I can do a rsync or fresh "git clone", however, is there any git
>> related commands to incrementally do this?
> I don't know whether there is a single git command to do it, but you =
can
> copy those 5 objects "by hand": in your backup, you should have a
> directory .git/objects, where you have the files
> =C2=A0 b7/1eb55f2dbc97dafd4a769fc61f346e69a5e0af
> =C2=A0 28/2035f3ae964e1e288f352c370be8edd11d3078
> =C2=A0 3c/20f556eecc476e3542cc522d46a62a4461fec6
> =C2=A0 f3/21b578edeb452358497e832815d6cae6b36886
> =C2=A0 6d/23f5084c975be637f7d748db82116bf84d3872
>
> It should be sufficient to just copy those files into the corrupted
> repo.
>
> However if you packed the git-files in the backup (e.g. by running "g=
it
> gc"), those objects might be found in a pack in .git/objects/pack.
> The easiest ist probably to use git-unpack-objects to unpack the
> objects, and then copy the 5 missing objects.
>
> Axel
>
> PS: Well, I'm using git and I like it -- but I'm no specialist; so fi=
rst
> do a backup, before you follow my proposal ;-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
