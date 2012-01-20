From: Jason Wenger <jcwenger@gmail.com>
Subject: Re: [PATCH v3] mergetool: Provide an empty file when needed
Date: Fri, 20 Jan 2012 08:03:01 -0600
Message-ID: <CAM6z=4-HfRAjJjnYqfoiYsYjiZJSsbkCaW-VtLWvoeFM0xsB9g@mail.gmail.com>
References: <7vy5t2g6za.fsf@alter.siamese.dyndns.org> <1327045655-3368-1-git-send-email-davvid@gmail.com>
 <CAJDDKr71Q9ihLZdP1Pu=ebpvX0EPvW-9bN6kZz9MeuhYKZzh+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 15:03:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoF3v-0007Ip-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 15:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2ATODY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 09:03:24 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40756 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2ATODX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 09:03:23 -0500
Received: by eekc14 with SMTP id c14so232818eek.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=omgv0B2H4LVI4xpV+9V0O2Qp81UoYfDOwU+qBmWvgJM=;
        b=YtAWOocNmXEpBmwIaUmYHXkaI5sqJJyT50M9f26rMRfeCrhC7vajKdfvWU8U/V1Fcx
         Asvc4zcRTdwwkZT8qXnJKnzcJxen1JpJ/066J8p03kq02c+TgNUfwIW0Uym5z/rwe1wB
         WcuSwoPpXSydSfBKzL/SN2B/OCy0sBl22vBv4=
Received: by 10.213.29.135 with SMTP id q7mr7260941ebc.49.1327068202233; Fri,
 20 Jan 2012 06:03:22 -0800 (PST)
Received: by 10.213.36.16 with HTTP; Fri, 20 Jan 2012 06:03:01 -0800 (PST)
In-Reply-To: <CAJDDKr71Q9ihLZdP1Pu=ebpvX0EPvW-9bN6kZz9MeuhYKZzh+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188879>

On Fri, Jan 20, 2012 at 01:53, David Aguilar <davvid@gmail.com> wrote:
> On Thu, Jan 19, 2012 at 11:47 PM, David Aguilar <davvid@gmail.com> wr=
ote:
>> Some merge tools cannot cope when $LOCAL, $BASE, or $REMOTE
>> are missing. =A0$BASE can be missing when two branches
>> independently add the same filename. =A0$LOCAL and $REMOTE
>> can be missing when a delete/modify conflict occurs.
>>
>> Provide an empty file to make these tools happy.

This is cleaner, yes -- but is this extra processing on $LOCAL and
$REMOTE necessary?  Git mergetool doesn't actually call an external
mergetool during del/mod conflicts -- instead it goes into an
alternate processing and prompts the user interactively whether to
take the deleted or modified file.  Can these changes be reached?
(command line option I'm not aware of?)

--jcw
