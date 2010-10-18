From: Jonathan Nieder <jrnieder@gmail.com>
Subject: empty structs
Date: Mon, 18 Oct 2010 13:42:09 -0500
Message-ID: <20101018184209.GD6877@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org>
 <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino>
 <m2y69vl67b.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ukA-00074h-Ht
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab0JRSrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 14:47:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44671 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101Ab0JRSrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:47:13 -0400
Received: by gxk21 with SMTP id 21so229476gxk.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LvdjkpOeYY6NAJr+VsAmrF4BLN4V5pZGMNUfdvXoqoc=;
        b=BwTW7+an9gYQITz8wCv0qnXaJYO5ZOeJyIc0cA7iKhWN4i9IYmqBKcQ2+i7QbIZ7kD
         ToA2A3hqghxQV+t9vx97jMrpEvBGVeNnf7eMPQgCppmTdinrYLOhQT2b3pLZD3Z0fEt9
         OqizlYtQkWg+ukiwU3IbXqdJbradwPmCvXzCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xRFLKy6TcHFiFj54tH14xs6UOFctehMZ2yN77sKACmzr3Mo1TWIo1gns4o3qcrI0u8
         u2Ik2+F276wJ68wNfIBpvaDvqgKdmesMJtt9Vqq4/EysIMYY/Kcb4BNHnPWJPjZ0sKz3
         L4etcG80byz9Y7RdSTnyWAtp/rtm4YabFRbK0=
Received: by 10.103.241.18 with SMTP id t18mr1844526mur.36.1287427547279;
        Mon, 18 Oct 2010 11:45:47 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d17sm3097641fav.29.2010.10.18.11.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 11:45:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2y69vl67b.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159281>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Just to throw an idea out: you can also do something like
>>
>> #ifndef NO_POSIX_GOODIES
>> struct credentials {
>> };
>> #else
[...]
> Empty structures are not standard C.

(For those following at home:

	"A structure type describes a sequentially allocated
	 nonempty set of member objects (and, in certain
	 circumstances, an incomplete array), each of which
	 has an optionally specified name and possibly
	 distinct type.")

So I guess future patches following the pattern of v1.7.3-rc0~33^2~13
git wrapper: introduce startup_info struct, 2010-08-05) should be
written like

	struct startup_info {
		char dummy;
	};

Yuck.  Thanks for the pointer.
