From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 2 Dec 2013 19:25:07 +0100
Message-ID: <CANQwDwe827gsq4pP_XN_ZUSxTJhZupijuVK0gwVJToNcEXDueg@mail.gmail.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
 <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
 <1385985997.2054.27.camel@localhost.localdomain> <xmqq61r7rua0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>, sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 19:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnYBt-0007YM-2W
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 19:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab3LBSZt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 13:25:49 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41302 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3LBSZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 13:25:48 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so5274086wid.17
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NXie2RY7Dlnpd26yXkgy/D6Qtz7lSL91kzdQ/L9hvEQ=;
        b=beGYiFQgwxI9cVRzhsoaJz18/l3sgg72q7lfQ+nSpJCx1gjSzZzppak5v6gmKrSSbx
         W9YCEF++UApqyGSPsIvFw+a9gRUpJihT4DX3pdEJZDBTHbGGmd+d9Jp1es55SnXYYvYN
         IQOm/uJ/jDN6qmEj77HqBWDyuWySFZf9KbUFxWFJJDO1IO9FRPklOcRSOHNQcsuRhNlu
         dJ81epTkwH7PyTZuQ6z430m/UqvUOoy3MDs/fRJ9dujClAr6lp0nBi0ED880fEQZX7JB
         lewNGwrZ9nwg9qxUVhammiFj9Q0pA/+UlTDKfDcDDJGYj3RDpvTpeBu/enG7gIXXIEXA
         YMuw==
X-Received: by 10.180.39.140 with SMTP id p12mr19415727wik.12.1386008747652;
 Mon, 02 Dec 2013 10:25:47 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Mon, 2 Dec 2013 10:25:07 -0800 (PST)
In-Reply-To: <xmqq61r7rua0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238642>

On Mon, Dec 2, 2013 at 7:18 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>> On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
>>> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
>>> <krzesimir@endocode.com> wrote:
>>>
>>> > Allow @additional_branch_refs configuration variable to tell gitw=
eb to
>>> > show refs from additional hierarchies in addition to branches in =
the
>>> > list-of-branches view.
>>> >
>>> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
>>>
>>> Why not use %feature hash instead of adding new configuration varia=
ble?
>>> I think that this option is similar enough to 'remote_heads' featur=
e
>>> (which BTW should be 'remote-heads'), and could conceveilably enabl=
ed
>>> on a per-repository basis, i.e. with repository configuration overr=
ide,
>>> isn't it?
>>
>> I'd like to see some consensus on it before I start changing the pat=
ch
>> again.
>
> I missed the remote-heads which is an existing feature when I
> commented; if this can be exposed to the users as an extension to
> it like Jakub suggests, it may be a better direction.

I think that additional-branch-refs (or just branch-refs) is different =
enough
from remote_heads feature (which is about showing "remotes" section
in "summary" view, and IIRC adding "remotes" view) that it should be
kept separate.

On the other hand it is similar enough that I think style of implementa=
tion
should also be similar, i.e. use %feature hash.

IMVHO

--=20
Jakub Narebski
