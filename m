From: demerphq <demerphq@gmail.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 11:42:06 +0200
Message-ID: <CANgJU+WwA0FfwVFWO23o0wLbpXNS+RXwwx=VKZ_J3e57r1pBsQ@mail.gmail.com>
References: <4FB9F92D.8000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 11:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWP88-0000Cb-7Q
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 11:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab2EUJmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 May 2012 05:42:08 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33972 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab2EUJmG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 05:42:06 -0400
Received: by ghrr11 with SMTP id r11so329527ghr.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JdziUP97g+sJNEeCDEU4CJFASxAh5M7MX4XvWtd0Qog=;
        b=sFSh2qlYymD8DHmrwBsM09Uez/hJjjH8LJB5K7ypPF9NbZjmOqfgxCofNCDmh9Wf7X
         k4Hf0ACaTSuXMBa8jktimwIoD44YI5OT85duF4xafGTsI7uaO3DzI3byne/40pfawUEC
         iIkRCRLUxII/IfTmT6dbjvv0CnlOLBjyQrDlhF8OdKQEIG/Dr5qwZCDukOWhbzNw26yT
         ySQxW+wEDCHbhjiMGxeDFKrbKkS4JrPY+R24NLX2jEEG3l0hJtwVaZD4SUjx9cVyy08S
         jihqB310Y0tu452S7OSOQcufhQrweOs1oQPnhi0WC25B4c6419PbLiex6t4IOzKs81N4
         HuVQ==
Received: by 10.101.218.19 with SMTP id v19mr6722492anq.63.1337593326180; Mon,
 21 May 2012 02:42:06 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Mon, 21 May 2012 02:42:06 -0700 (PDT)
In-Reply-To: <4FB9F92D.8000305@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198099>

On 21 May 2012 10:13, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I just noticed that the remove_duplicates() function in builtin/fetch=
-pack.c
> is O(N^2) in the number of heads. =A0Empirically, this function takes=
 on the
> order of 25 seconds to process 100k references.

Does "heads" in this context include tags? Sorry if this is a stupid qu=
estion.

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
