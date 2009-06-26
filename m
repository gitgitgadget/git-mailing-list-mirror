From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 18:03:44 +0100
Message-ID: <C66ABE00.20643%jefferis@gmail.com>
References: <vpq7hyzqf1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKEr0-00056q-7F
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760798AbZFZRDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759748AbZFZRDq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:03:46 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:64761 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760758AbZFZRDp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 13:03:45 -0400
Received: by ewy6 with SMTP id 6so3557291ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version
         :content-type:content-transfer-encoding;
        bh=+xbgHLCDlHzffIVYaUfoPQBF+3HkRD2QrjgBf0IqEFE=;
        b=VKLQa9hU5mQ2BOtcO7/jbtCVgrmK0Lv6I1hM/LbOXHg3cixb8EQ6JIS8bWod0UmEAD
         eCuMqPN4qdH2C4QuVHaJO+ykkZk3S9beCQ+en6EVMZx9piZwFCxiWqjNwb8NECAm0tfQ
         wE3O6HIBEGOxdEO4I0MkN1Ca6LIIiYpZboz8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :thread-index:in-reply-to:mime-version:content-type
         :content-transfer-encoding;
        b=FOsk3IQCcEWq7TUaQi2522SN+WZG1vg7IDBD15vl3zE1gPw4JgaOO/lNWamyfQlpPv
         4kHTVQGjSp+lEhg5IuIdFuWIA3aSG4YFNMm5sXWdzfF2mW1Jyu2DnQyumXsJ0LWmHwB0
         8rw+SSWts0RXgXZPcDr8WVS7iuGDJqzO1E4T4=
Received: by 10.210.13.12 with SMTP id 12mr2235417ebm.8.1246035827942;
        Fri, 26 Jun 2009 10:03:47 -0700 (PDT)
Received: from ?10.6.0.183? (nat.mrc-lmb.cam.ac.uk [131.111.85.79])
        by mx.google.com with ESMTPS id 24sm84009eyx.53.2009.06.26.10.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 10:03:47 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.13.0.080930
Thread-Topic: Choosing a mergetool according to file type
Thread-Index: Acn2gA/p35aWdH9ESkezvyp5fNV+6w==
In-Reply-To: <vpq7hyzqf1i.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122308>

Hi Matthieu,

On 2009-06-26 14:51, "Matthieu Moy" <Matthieu.Moy@imag.fr> wrote:

> Gregory Jefferis <jefferis@gmail.com> writes:
> 
>> This defines the merge driver but not the mergetool.  A mergetool is
>> presumably an interactive tool that helps you clean up failed automatic
>> merges.
> 
> This is why I quoted the title of the section
> 
>>>        Defining a custom merge driver
> 
> Just tried it with
> 
> [merge "filfre"]
>        name = feel-free merge driver
>        driver = gedit %O %A %B
>        recursive = binary
> 
> It did launch gedit interactively during the merge.

Hmm, I had of course looked at this but this thought that it wouldn't do
what I want. For one, I thought this would _always_ call gedit even if the
file is unchanged in remote. Testing, however this doesn't seem to be the
case. So I think you're right that this method can be used satisfactorily
even with an interactive merge and I have made a little script that seems to
do what I need.

On the other hand to me it does somewhat violate the separation between
automatic and interactive merging and one probably has to be quite careful
about what state the merge files are left in - presumably things that
whoever wrote the builtin "binary" merge thought about carefully.

All the best,

Greg.
