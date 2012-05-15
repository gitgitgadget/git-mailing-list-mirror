From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and index-pack
Date: Tue, 15 May 2012 18:25:39 +0700
Message-ID: <CACsJy8AjtE_K53toP6WHh6W9aDSxEur+xOt3wQQ=cDuhBcLuhA@mail.gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1205121326380.21030@xanadu.home> <CACsJy8DxoRHYnBvJn7P9dS1A0Y88Bm0ur1meWCUBp09UEfuOgg@mail.gmail.com>
 <CAGdFq_hneGBtjKHk=jqmgrVgYFKEFYLTnyS+-OemwL4z7JKmKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 13:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUFtQ-0003j6-KB
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 13:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449Ab2EOL0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 07:26:11 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39769 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab2EOL0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 07:26:10 -0400
Received: by wibhj8 with SMTP id hj8so2688926wib.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FIBNIMIWHfC146UQLRGKKOGP5Yzcg37RxYWQqbcHetw=;
        b=hkvS35bx+xQ/nsHtSCvxLBLojATFR6MhhcM6LZXHsc7rAUqWzL++5H2FGnB5Q0VOM4
         eqodgXQaNGO1PEXXRriD3NDY0ITTLxPnQ/VG6t1Eeezx4jI6bIIRh9KOXeeI+KitRM+c
         +2q6LRGTZrK8euTRihw5h6H3z9YkxC9XSDgew4tP27NFF1jH+6/KswB7UKUkem/QjI4D
         iboT5CO2mgpeaYH3FA3nZj+o+4YW5zF+f0ommeXTx9RUAHQ6sK4nIKd2wz5OAMd8bpnA
         i4xUDfJ7sI0rIC2I+RV4mCCRfDgoUuV92y+QzkJI1cg17fVKqCfYorVDXMMLppguoV9R
         AfuA==
Received: by 10.180.82.136 with SMTP id i8mr12053136wiy.19.1337081169508; Tue,
 15 May 2012 04:26:09 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 15 May 2012 04:25:39 -0700 (PDT)
In-Reply-To: <CAGdFq_hneGBtjKHk=jqmgrVgYFKEFYLTnyS+-OemwL4z7JKmKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197827>

On Mon, May 14, 2012 at 10:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Mon, May 14, 2012 at 4:09 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> I'm good with always warning too. The moment it shows up, I can just
>> open another terminal for "gc". Though (I guess) a new user in the
>> middle of the work may not want to do that as they fear "gc" may
>> interfere their work.
>
> If we know that it won't interfere with their work, can we just spawn
> git gc as a background process?

I thought of that for index-pack, but we would need to deal with error
messages from gc messing up with foreground command's. I don't like a
command leaving background processes (without asking me) after it
exits, so index-pack should hang on until gc finishes. Which is ok for
long time commands like index-pack, but not ok for commit, rebase...
-- 
Duy
