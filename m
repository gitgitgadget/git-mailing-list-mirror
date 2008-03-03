From: Sergei Organov <osv@javad.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 20:18:45 +0300
Message-ID: <87hcfnu3nu.fsf@osv.gnss.ru>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	<vpqskz82bm3.fsf@bauges.imag.fr>
	<4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
	<vpq63w325px.fsf@bauges.imag.fr>
	<4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
	<alpine.LFD.1.00.0803031057140.2899@xanadu.home>
	<4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEKt-000525-RO
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761298AbYCCRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761005AbYCCRTY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:19:24 -0500
Received: from javad.com ([216.122.176.236]:3283 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761330AbYCCRTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:19:23 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m23HIqi57053;
	Mon, 3 Mar 2008 17:18:52 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JWEJJ-00048c-SA; Mon, 03 Mar 2008 20:18:45 +0300
In-Reply-To: <4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com> (Paolo Ciarrocchi's message of "Mon\, 3 Mar 2008 17\:51\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75953>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
> On Mon, Mar 3, 2008 at 5:29 PM, Nicolas Pitre <nico@cam.org> wrote:
>> On Mon, 3 Mar 2008, Paolo Ciarrocchi wrote:
>>
>> > On Mon, Mar 3, 2008 at 4:21 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

[...]

>> > How can I look to what I just downloaded?
>> > Should I simply do a git diff?
>>
>> If you have reflog enabled (it should be by default) then a good thing
>> to remember is the @{1} notation.  For example, if the fetch updated the
>> origin/master branch, then origin/master@{1} is what your origin/master
>> was before being updated.  To see the difference between the previous
>> and the current state of origin/master, you can do:
>>
>>        git diff origin/master@{1}..origin/master
>>
>> Or to see the list of new commits:
>>
>>        git log origin/master@{1}..origin/master
>>
>>        git log -p origin/master@{1}..origin/master
>>
>> Etc.
>
> Very nice, I didn't find in the documentation.
> I'll read again the documents and if needed, I'll propose some new text.
>
>> This notation is a bit obnoxious and the re were suggestions about
>> addind the equivalent origin/master@{1..} but that didn't materialize
>> yet.
>
> Mybe it's just me but wouldn't be very nice to have a simple command
> to look at what data have been used for updating the currente branch?
> i.e.
> git fetch
> git diff -- fetch (which is an alias of git diff
> origin/master@{1}..origin/master)
>
> And how about a repository which have reflogs disabled?

I'm also a newbie, and I think you are on a wrong road. Usually it's not
that interesting what was downloaded. What is interesting is what is on
'origin/master' that is still missing from 'master'. For this I think
you have:

$ git log master..origin

-- Sergei.
