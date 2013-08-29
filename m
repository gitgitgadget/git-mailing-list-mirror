From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 17:55:44 -0400
Message-ID: <CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFABy-0005Rg-0O
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab3H2Vzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:55:45 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50449 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab3H2Vzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:55:45 -0400
Received: by mail-ie0-f180.google.com with SMTP id x14so1757568ief.25
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h8OOtZI53va2pYoYtVn3Fwwe02clyQKoyBHQLp7GIhE=;
        b=oapzyOmrVWvy5hV5IouTBL61I20zdZ9M2SWP9tpkDcKgjkYaI3V4HeEcdsy6YlUZ5b
         jJBGJAgQauaV0qXvAkEyb3CftKfJP3nlzt0ESCci0a5YQX3zOSXM4l2aCvdcMdBrkQj/
         NcgtrmzqZy31uRDypFMBlpP5LmBt2UmVHaQGQgs8+niykUt39HbS8uIZ8OsWZmWXojFc
         60zjaRP3rHbumGTd517S8csb8T9Nhs75H1BijjxsTS4GstaXtCK/jLAz8O8N6R8OMSxZ
         7xC20D4GHhx2BCG2tWQI+xF2E+BOqq3tN3/r38F7/YIprdVG/DRyDwR5X0tcH/NWLPn9
         GVKw==
X-Received: by 10.50.88.7 with SMTP id bc7mr17800758igb.37.1377813344770; Thu,
 29 Aug 2013 14:55:44 -0700 (PDT)
Received: by 10.43.1.68 with HTTP; Thu, 29 Aug 2013 14:55:44 -0700 (PDT)
In-Reply-To: <xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233372>

On Thu, Aug 29, 2013 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It has been discussed many times in the past that 'index' is not an
>> appropriate description for what the high-level user does with it, and
>> it has been agreed that 'staging area' is the best term.
>
> "add" is the verb, not "index" (which is a noun that refers
> to the thing that keeps track of what will be written as a tree to
> be committed next).
>
> And it will stay that way.
>
> IIRC, when this was discussed, many non-native speakers had trouble
> with the verb "to stage", not just from i18n/l10n point of view.

I agree with Junio. This effort is better spent making the
documentation clearer and more succinct. The reality is that a user
needs to build a model in their mind of what they are doing which maps
enough (completely is not required) to what is actually going on to
get work done. If the documentation or the instruction is getting in
the way of that in the name of simplifying the presentation then the
presentation is wrong.

We add content snapshots to the index of content (creating
"temporary"--they will be garbage collected eventually if they become
orphans--objects into the store at the same time). We build commits
from those snapshots (in whole or in part, typically only using the
most recent snapshots of new things added to the index) and save those
in the object store with the content and tree objects. Sometimes we
create tag objects to record something special about commits, trees,
and content blobs.

That's the real model (with some rough edges). Explaining what that
has to do with distributed version control is the hard part.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
