From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 14:45:33 +0200
Message-ID: <81b0412b0909210545n3da664c4r4e9250fa2eb241c4@mail.gmail.com>
References: <871vm0k6jm.fsf@meyering.net>
	 <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
	 <87ocp4imul.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 14:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpiH0-0004d1-B6
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 14:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbZIUMpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2009 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbZIUMpb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 08:45:31 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:42145 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbZIUMpb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 08:45:31 -0400
Received: by bwz6 with SMTP id 6so1899145bwz.37
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/w9mlVjCjROyRYn0TYE0DxtZkKxKk4AzESPbDZLxMXM=;
        b=cmQwtHc8xHYgaeHbuElibQcDpAF/iYMcNXa2f+n3at4mmCMQ5Krk6hWPpR3mvfO8xk
         XGesvR4brrM/oDY4Z+FFK5ZeAasA003VTQGEBRm68GJ7q0wyK268e4BWtVFqRL6XSCMO
         6y127LhghCYh3ihAYN+Hz19Ncpt7m5qrbu+hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tPAKHC3MuG4UO1+czSnmmVJvIeDBYOdwqUImMKq4RktdDUAgAt30HJBwGi5xxNjhCi
         7DV2XF+8q5bNb4qupAh0ai8ZoEFts6vraNBxEqcWOX3zZO/nqpk05sWydkrfkW5ONj5X
         FSsDsBNFZD5c7GwM3CvHH/8TW3yxK4rhHrb28=
Received: by 10.204.13.210 with SMTP id d18mr4212798bka.211.1253537134005; 
	Mon, 21 Sep 2009 05:45:34 -0700 (PDT)
In-Reply-To: <87ocp4imul.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128875>

On Mon, Sep 21, 2009 at 13:00, Jim Meyering <jim@meyering.net> wrote:
> Alex Riesen wrote:
>> On Mon, Sep 21, 2009 at 11:09, Jim Meyering <jim@meyering.net> wrote=
:
>>> However, if the use of [] is deliberate, because git still
>>> cares about portability to ancient SYSV versions of tr that
>>> require that notation, then let me know and I'll undo that part
>>> of the change and add a comment to that effect.
>>
>> We have (had?) people trying to support Git on HP-UX and SunOS.
>> Do these count?
>
> I had my doubts, but have just confirmed that Solaris 10's
> /usr/bin/tr is still doing it the SYSV way:
>
> =C2=A0 =C2=A0$ echo foo | LC_ALL=3DC /usr/bin/tr a-z A-Z
> =C2=A0 =C2=A0foo
>
> There, you have to use /usr/xpg4/bin/tr to get the expected behavior:
>
> =C2=A0 =C2=A0$ echo foo | LC_ALL=3DC /usr/xpg4/bin/tr a-z A-Z
> =C2=A0 =C2=A0FOO
>
> So you're right. =C2=A0...

Sorry about that. I even made a simple tr once for Git tests
exactly because of compatibility problems (look for "poor man tr"
in the list archives, if needed).
