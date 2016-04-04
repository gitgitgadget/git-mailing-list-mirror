From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 4 Apr 2016 23:31:05 +0300
Message-ID: <CAJPOeMeqMpy8wmZ3jMfw_XLAS2WbPOtJF8_Rd_sPGQNeCNyFnw@mail.gmail.com>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com> <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 22:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anB9w-0003IJ-H3
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbcDDUbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 16:31:36 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34332 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcDDUbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 16:31:36 -0400
Received: by mail-qg0-f66.google.com with SMTP id j35so18707504qge.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0DrwXn2DTxifcedN5XRwocDcqLO7t6DdItitgarv9O4=;
        b=kj+6k9AvM5ZdRA01KsODDUjhJUNgHPe3028D2BSvjIIRl3MHN7qpOtkWDemBVHMO+5
         /b0Wll+oySTuDJ8S9nO7HwcH+MCcXE99AwbVHxMBuGGjS/QKI7JSlg+NfyFPmSRDuDSo
         RLJCxDm/SR1t4k0fSaAxutAcHhTtOYLfEto86u4UC2F+rwGEN9yshbsBw8N+xJznJ853
         jtEg8GDYVw2zeN6Soa2eIULcaE47GJ6ZKu4fISQ/3lM5ZJu5EECpfZTmiMyAR60/h6lX
         zIwR702Onp/QFgg171MuzjW8gtbnYhXNW2SdoQs+qw1WJ+pBQcixX4/O2W4lFHL1znoC
         xJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0DrwXn2DTxifcedN5XRwocDcqLO7t6DdItitgarv9O4=;
        b=XMtLXeWSf2D2tje+v1/e17vpSBotzXc5AWS7fKTduP5fOaAh0h9JRbp32lBU8HS427
         GtZdar1DVuQJWtJDhhHkThK/BW6dny5fx3AocABulh6Y+QLv4+R+Tvh8axnLlWz0eiG2
         h96dFcy0LyawgxrHtq9ypP1MioOdiwX9UdoHWox0VpKyKIbN/esN4LQZvpC4yUFibnVd
         0WjYgoPr0P6ZGVUYnlq4Vo1QkicODHl/iuD0lxHRt5E5pTfbUz9Wuc0Nmuj8etySxll7
         icpbm2n4vgb4rUGVW8mXBDv+VDF/vLp+Gs+Yvee8wZGo81ywhxigA7N2t1jK1HUNR7QW
         wb1Q==
X-Gm-Message-State: AD7BkJISz+ill3R9tuyRE7O/x7lfEor9jXV0j9bMygqfxoXBtCLWLna0y9+OlCY5k8HuNk2h5nxYhOObQS0KTA==
X-Received: by 10.140.28.52 with SMTP id 49mr24324785qgy.66.1459801895139;
 Mon, 04 Apr 2016 13:31:35 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Mon, 4 Apr 2016 13:31:05 -0700 (PDT)
In-Reply-To: <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290722>

On Thu, Mar 31, 2016 at 6:31 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Elena Petrashen <elena.petrashen@gmail.com> wrote:
>> +void delete_branch_advice(const char *name, const char *ref)
>> +{
>> +        const char fmt[] =3D
>> +        "\nNote: to restore the deleted branch:\n\ngit branch %s %s=
\n";
>
> Shouldn't that be marked for translation, like is done with the other
> strings?
>
> Thanks,
> R=C3=A9mi

Thank you for letting me know about that! Could you please
help me out and explain how do I mark it for translation? I tried
to do it the same way as with the other strings but evidently
didn't quite succeed.

Thanks!
Elena
