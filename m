From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 19:15:19 +0700
Message-ID: <CACsJy8D10yXoxynOscWjCyAq8qxeXOCMJLqkFYzSRUokUgYF8A@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
 <CALkWK0nhmks6LqoALA8hrwkR00NjweyqV2RJ9-9V3q-bjgpsCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 13:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHvSk-000361-1i
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 13:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab3CSMPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 08:15:51 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:57720 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3CSMPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 08:15:50 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so360345oag.29
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ioP267ZjHWCbeapW0LCd/niKibu96sLpcpib+o13bSI=;
        b=vaZwmIgBzavSsaq50FJiYg0msmdnn1WM7HFWlA7nVc4p+ELEKyLE7RuiFKjTleAON+
         UXCGeaj9fJ/niBihbNKwK2ceC7I3ynnSIRMyJzvHactKey2L+W56QP9Z9YyTQkqR5wqb
         hQVd2RZud3Dd3N4mcevzAv2K+mQuf5yM2LuE3YHDAT1SPFizRSzI/Fqi0zn3PsjRR5T7
         Nh+EnxaEAoInqw7aT/Kype/GLucBD8n9byLRoBPMd7hNtONGsUkD+rx0Q6umoykMRNkV
         u0+EHiife8B5+025Sjo6zwRzfELPD5YhDYXEFvPEoiJ1mILtRBxHMUn7Y0LxFdjagIKu
         ZnpQ==
X-Received: by 10.182.43.103 with SMTP id v7mr1096334obl.17.1363695349763;
 Tue, 19 Mar 2013 05:15:49 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 05:15:19 -0700 (PDT)
In-Reply-To: <CALkWK0nhmks6LqoALA8hrwkR00NjweyqV2RJ9-9V3q-bjgpsCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218508>

On Tue, Mar 19, 2013 at 6:53 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>> git push . foo:bar
>
> A URL may be a path to a git repository, and '.' is a valid path.
> Currently, 'git push .' seems to push to the current repository (what
> does that even mean?).  For something truly unambiguous, we'll have to
> use a character that's disallowed in URLs and isn't interpreted by the
> shell- I can't seem to think of one.  Otherwise, we'll have to
> fallback to using heuristics anyway.

Yeah that was a stupid suggestion. There's also "-". Right now git
push accepts it as a remote name, but I think in general "-" alone has
always had a special meaning in UNIX world. We could put a new meaning
to it (literal "-" directory can be specified with "./-"). Not totally
sure if "-" is allowed in refspec though.
-- 
Duy
