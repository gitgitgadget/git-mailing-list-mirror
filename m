From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] status: fix tests to handle new verbose git status during rebase
Date: Wed, 03 Jun 2015 11:25:38 -0700
Message-ID: <xmqqvbf4wswt.fsf@gitster.dls.corp.google.com>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433320545-14244-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<vpqmw0gadth.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guillaume =?utf-8?Q?Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DMI-0003WQ-AR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbbFCSZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 14:25:42 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35519 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbFCSZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:25:40 -0400
Received: by iesa3 with SMTP id a3so19665097ies.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Kks/YR23byt+TDSZYs+mIrtW4d7f6JZbeQT1herqT5U=;
        b=0P4DPeSBENXH/16Ynvu0YdRaVEoI2gqbgp6XYAOTmVz82OGlQ/CwX25fujYQSUyh3a
         idli4pq2Ol+qs4hwNKl79hNLX1rUAtZIoCQJMiEYm4laTZVR4by9K3KDa32jwcuaXa8c
         jqqrcogOta4tnrGc4nGK9Dy6v0MhFdRFsfxIgATsem+wiIf/jdW2UJKkxCiHOFa7t3Dk
         kaAuNuoqZchRrosoRnqbucWEkVkZcG6GC9LgIzTn2vUCFXnvgF3y9jOkHRCJQgPFR5Nu
         hvdhjCHJtyLtsag60AZ5vd9oTkAG0oonxyDpWxrrI1bJwpqb0gsrWJ3CGtbjt6n2WGcm
         /3Aw==
X-Received: by 10.107.5.210 with SMTP id 201mr41213437iof.88.1433355940160;
        Wed, 03 Jun 2015 11:25:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id j5sm13493660ioo.8.2015.06.03.11.25.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 11:25:39 -0700 (PDT)
In-Reply-To: <vpqmw0gadth.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	03 Jun 2015 19:42:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270721>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr> writes=
:
>
>> Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenobl=
e-inp.fr>
>> ---
>>  t/t7512-status-help.sh | 227 ++++++++++++++++++++++++++++++++++++++=
++++++++---
>
> Your history is not bisectable if you sparate tests and code changes =
in
> two patches.

Yes.

And by squashing the two, you do not have to label 2/2 incorrectly
as "fix tests"; it is merely fixing what 1/2 broke ;-)

> Plus, as a reviewer, I like seeing changes to the tests next to chang=
es
> to the code, to show me what is the impact of the code change on the
> output of the program.

That too. is a very important consideration, maybe even more so than
bisectability.

Thanks.
