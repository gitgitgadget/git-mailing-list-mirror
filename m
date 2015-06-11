From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow to control the namespace for replace refs
Date: Thu, 11 Jun 2015 13:55:01 -0700
Message-ID: <xmqqvbeudkyi.fsf@gitster.dls.corp.google.com>
References: <1433987235-17385-1-git-send-email-mh@glandium.org>
	<xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
	<20150611051339.GA3637@glandium.org>
	<xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
	<20150611204611.GA10114@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z39VI-0006Gt-GP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbbFKUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:55:08 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:35114 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbFKUzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 16:55:06 -0400
Received: by iebtr6 with SMTP id tr6so5163426ieb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9CN/qtdowkL0C3YI+HsaNFsGGpk8XXRagPSJt7zKeWQ=;
        b=QpmrYUjBP6l4XpbkwAdlR13bMVIb+vhb3UM/SptEruuASIhow/22SAXWj995adV/kV
         49UDoD/dpm3T58nRFjaguGHNVzvNgPjiPZwC/IF65tS7vNbBnacnC5PR3mBotigiT1Ip
         Lzc+6wUREwQmrmrLWSC0nCw4FBy7aMeYYFZbv1PkQ/0CTJtYXj0KKeRzU6y1U5hmnY7Q
         zjiSsv9WPArxuDMgJer2zCsxG2ERl5QRsfXut9Y6KvWrHbetcNx5coLujM6WE4aaj6fD
         msWYwxHTeTQf6Az5b7rIUe1WjQBBTFpnQCac93yYueED9S8/u64UMjdDbB0iPWTK6zXX
         9IcQ==
X-Received: by 10.43.140.5 with SMTP id iy5mr13188465icc.77.1434056103366;
        Thu, 11 Jun 2015 13:55:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id h128sm1124878ioh.38.2015.06.11.13.55.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 13:55:02 -0700 (PDT)
In-Reply-To: <20150611204611.GA10114@glandium.org> (Mike Hommey's message of
	"Fri, 12 Jun 2015 05:46:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271464>

Mike Hommey <mh@glandium.org> writes:

> On Thu, Jun 11, 2015 at 08:16:02AM -0700, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > I do agree that this is all confusing, but allow me to point out that
>> > it's already plenty confusing: "namespace" is a term that has been used to
>> > designate a generic kind of namespace *and* refs/namespaces. See for
>> > example:
>> >
>> > https://github.com/git/git/blob/master/Documentation/git-describe.txt#L39
>> > https://github.com/git/git/blob/master/Documentation/git-fetch.txt#L113
>> > https://github.com/git/git/blob/master/Documentation/git-filter-branch.txt#L36
>> > (note how this one is specifically about refs/replace/)
>> > there are many more.
>> 
>> "One more breakage does not hurt" is not something we want to see.
>
> I won't disagree here, but we are in desperate need for a word for those
> namespaces that aren't refs/namespaces, and stick to it (independently
> of the replace patch), but I've never seen one.

I actually don't agree with you ;-)

All these examples you cited above are merely talking about
hierarchy and they do not have any desperate need for a new word.

They do not even need a technical term; they needed a way of saying
"subdirectory" without limiting their reference to loose refs.  If
there weren't packed-refs, they would have said ".git/refs/heads and
its subdirectories" and that would have been perfectly fine.

The "ref namespace" I mentioned in my first response is the only
special one, I would think, so if we reword everybody else to say
hierarchy instead of namespace, we are perfectly fine, I think.
