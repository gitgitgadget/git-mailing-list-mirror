From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Re: [PATCH] Documentation: setup-git-server-over-http: Mention davfs2
Date: Tue, 19 Aug 2008 09:23:39 +0200
Message-ID: <c475e2e60808190023r2984cea3r11bd27fd331234b4@mail.gmail.com>
References: <48A9E8BE.9040807@gmail.com>
	 <1219095967-15971-1-git-send-email-gafunchal@gmail.com>
	 <7vwsidh7hi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	git@wingding.demon.nl, Matthieu.Moy@imag.fr
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:24:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLaA-0000h8-7Q
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYHSHXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYHSHXm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:23:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59868 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYHSHXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:23:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1371552nfc.21
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=24LoHjMGxkMsCutv4gU8XvUfHlfn7CfQtOakngjVYwo=;
        b=e/QCx1ObzAw/v9G+ZF2/SiA9sl63xDJUBD0M/bxU3/5NJAaqQqJVjMIzZvrGIXzqss
         h4P+kZLxS8lU001pDjmrW/Gz9EJqAd8ICqT2Io568zPvRZ3YpGLx6YqkHwUo9iH/Z822
         Jel7qcFPnyG3UfTdMHAC76wJeXDlcyXo7+P9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FNWh/EO6lPU123FrMKAOIYc1qIm7KsfwMTZXQfVdFvWsTz5t++4ZXByjLUOPX8iyGU
         CYPNkasi6n5VcfNZuN8orJMxufEC82Dq6errcqF4+SMll4S1pZcMCqjkyP3mfWmeTPja
         GzmErD7T5h/TIRHYwolU/pD8eO4FVXEQmv+NE=
Received: by 10.187.205.16 with SMTP id h16mr420165faq.66.1219130619749;
        Tue, 19 Aug 2008 00:23:39 -0700 (PDT)
Received: by 10.187.245.17 with HTTP; Tue, 19 Aug 2008 00:23:39 -0700 (PDT)
In-Reply-To: <7vwsidh7hi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92819>

> Googling for "davfs2 WebDAV" returns 13,600 hits, while "cadaver WebDAV"
> hits 39,100.

Woops, sorry for that, in fact I greatly misunderstood the statement
"A command line tool to test WebDAV is cadaver." I though this meant
"The command line tool is dead / It does not exist anymore". I didn't
realize "cadaver" was its name!

> In addition, testing with davfs2 requires you to have root access.

When davfs2 is properly configured, the file system can be mounted in
user space by non-root users. Root access is needed only when
installing. Cadaver also needs root access for installation,

-- Giovanni

On Tue, Aug 19, 2008 at 7:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giovanni Funchal <gafunchal@gmail.com> writes:
>
>> I just came across an interesting file system driver that allows to mount
>> WebDAV resources into file system tree: davfs2. I though it would be worth
>> mentioning this on setup-git-server-over-http.txt.
>
> I might agree with "It would be worth mentioning", but I do not think that
> is what you did.
>
>> +
>> +Step 2 1/2: testing your WebDAV server
>> +--------------------------------------
>> +
>> ...
>> -A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
>> -example, konqueror can open WebDAV URLs as "webdav://..." or
>> -"webdavs://...".
>> +An alternative is to use davfs2, a driver that allows mounting a WebDAV
>> +resource into the system tree. This requires root access and kernel
>> +support (probably your kernel includes this).
>> +
>> +  $ apt-get install davfs2
>> +  $ mkdir -p /mnt/webdav
>> +  $ mount -t davfs http://<servername>/ /mnt/webdav
>> +  $ ls /mnt/webdav
>> +  $ umount /mnt/webdav
>> +
>> +If you prefer GUIs, for example, konqueror can open WebDAV URLs as
>> +"webdav://..." or "webdavs://...".
>
> You are dropping mention of cadaver and the only remaining suggestion for
> command line testing is via davfs2.
>
> Googling for "davfs2 WebDAV" returns 13,600 hits, while "cadaver WebDAV"
> hits 39,100.  In addition, testing with davfs2 requires you to have root
> access.
>
> When troubleshooting a nonworking system, it often is easier to do it from
> a command line tool than from GUI (one of whose main point is to hide away
> the low-level details).  And I thought the title of this semi-section was
> "Testing"?
>
> Offering alternatives for command line tools is good, but that is not what
> this patch does.
>
>
>
