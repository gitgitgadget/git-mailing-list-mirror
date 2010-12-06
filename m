From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3] parse-remote: handle detached HEAD
Date: Mon, 6 Dec 2010 15:32:55 +0100
Message-ID: <AANLkTik4LLCm3WzcKPkOY44M88vF7oT2nuLrv-S3L22X@mail.gmail.com>
References: <7vfwubtw1g.fsf@alter.siamese.dyndns.org> <1291630811-16584-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 15:33:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPc86-0006F8-0r
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 15:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab0LFOdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 09:33:19 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63440 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0LFOdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 09:33:18 -0500
Received: by qyk12 with SMTP id 12so14522531qyk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 06:33:17 -0800 (PST)
Received: by 10.229.246.136 with SMTP id ly8mr4387700qcb.237.1291645997444;
 Mon, 06 Dec 2010 06:33:17 -0800 (PST)
Received: by 10.229.183.20 with HTTP; Mon, 6 Dec 2010 06:32:55 -0800 (PST)
In-Reply-To: <1291630811-16584-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162994>

On Mon, Dec 6, 2010 at 11:20 AM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> get_remote_merge_branch with zero or one arguments returns the
> upstream branch. But a detached HEAD does no have an upstream branch,
> as it is not tracking anything. Handle this case testing the exit cod=
e
> of "git symbolic-ref -q HEAD".
>
> Reported-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Santi B=E9jar <santi@agolina.net>
> ---
>
>> If that is the case, shouldn't we be not calling "echo" at all to be=
gin
>> with? =A0IOW, shouldn't the code read more like this?
>>
>> =A0 =A0 =A0 =A0curr_branch=3D$(git symbolic-ref -q HEAD) &&
>> =A0 =A0 =A0 =A0test "$origin" =3D "$default" &&
>> =A0 =A0 =A0 =A0echo ...
>
> Or course, you are right. I didn't know/think about the exit
> code... Thanks.

Now that I think of... the final form of the patch is yours (Junio).
=46eel free to add something like this to the commit message:

=46inal patch form by Junio C Hamano

Or alternatively, take ownership of the patch and add something like
"Patch handled by Santi B=E9jar but final patch form by Junio C Hamano"
and:

Acked-by: Santi B=E9jar <santi@agolina.net>

Santi
