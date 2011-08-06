From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 01/40] test-cleaner: automate whitespace cleaning of test scripts
Date: Sat, 6 Aug 2011 19:17:26 +1000
Message-ID: <CAH3AnrpkNRU=cXx2VN+cLb-R=d3Exr6fteQr=N-WJuq1E=JqzA@mail.gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
	<1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 11:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpd0e-0001LQ-Gh
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab1HFJR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 05:17:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38817 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab1HFJR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 05:17:27 -0400
Received: by vws1 with SMTP id 1so2417536vws.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GrQx1ZVoAO3yxhsxzP2gA09S4ytTSElFCqqQXrj/kkU=;
        b=qFG13DH1tgQYdJoQwLHAcXpubqVGHbKr78iA4BZvGCqWtcQH9H7FWUP6pNDMd0feLx
         zQV2zUvJY2uAmqOKOOEtaSkHOlPnnQH6qPPVLhVh6M1mgIsB/mMG6s1U9QaZDXBsuorn
         aZzChYPRbS7eubCCcMTX9/YdgKyRZBxyOsbaw=
Received: by 10.52.69.147 with SMTP id e19mr3449588vdu.399.1312622246641; Sat,
 06 Aug 2011 02:17:26 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sat, 6 Aug 2011 02:17:26 -0700 (PDT)
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178873>

On Sat, Aug 6, 2011 at 6:44 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> This script allows the automated cleaning of test scripts.
>
> Any whitespace fixups of a test script that do not effect the
> exit status or output of the test are assumed to be safe
> and are automatically committed.

Actually, this is not true - commits are generated, if the file
matches the filtering criteria for the fix subcommand specified.

> If no arguments are supplied, file arguments are read from stdin.

Should I use - for instead?

> +
> +fix_whitespace_auto()
> +{
> + =C2=A0 =C2=A0 =C2=A0 check_whitespace "$@" 2>/dev/null | grep "^AUT=
O" | fix_whitespace
> +}
> +
> +fix_whitespace_auto()
> +{
> + =C2=A0 =C2=A0 =C2=A0 check_whitespace "$@" 2>/dev/null | grep "^MAN=
UAL" | fix_whitespace
> +}

Both these need cut -f1 before the fix_whitespace stage.

jon.
