From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Mon, 14 Jan 2013 05:48:18 +0100
Message-ID: <50F38E12.6090207@alum.mit.edu>
References: <cover.1358018078.git.john@keeping.me.uk> <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk> <50F2296F.8030909@alum.mit.edu> <20130113161724.GK4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 14 05:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuc5Q-0007hq-KD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 05:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab3ANEz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 23:55:26 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:48944 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754273Ab3ANEzZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 23:55:25 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Jan 2013 23:55:25 EST
X-AuditID: 12074412-b7f216d0000008e3-d0-50f38e17c326
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 22.56.02275.71E83F05; Sun, 13 Jan 2013 23:48:23 -0500 (EST)
Received: from [192.168.69.140] (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E4mKtR024744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jan 2013 23:48:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130113161724.GK4574@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqCve9znAYMkyOYurW3wsDj7Os+i6
	0s1kceP8LlaL+TfOMjqweuycdZfd4+yjB8wey752snh83iQXwBLFbZOUWFIWnJmep2+XwJ3x
	+th6xoKfMhVz739lbGDsEO9i5OCQEDCR2Dedu4uRE8gUk7hwbz1bFyMXh5DAZUaJp5172SGc
	M0wSH0//YwGp4hXQlph//xwjiM0ioCrx8+JXVhCbTUBXYlFPMxOILSoQILF4yTl2iHpBiZMz
	n4D1igDVT/t0AyzOLLCMUaL1lgWILSwQIvF8zhZGiGXHGSXO3P7IBpLgFDCUOHbhBVSDjsS7
	vgfMELa8xPa3c5gnMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPL
	zSzRS00p3cQICWyhHYzrT8odYhTgYFTi4d1Y8jlAiDWxrLgy9xCjJAeTkihvchdQiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkghvaB1QjjclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoR
	TFaGg0NJgtesF6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDt
	VQRp5y0uSMwFikK0nmLU5dj+u/05oxBLXn5eqpQ4rzxIkQBIUUZpHtwKWBp7xSgO9LEwbxZI
	FQ8wBcJNegW0hAloydkL70GWlCQipKQaGDerHpRvvfVJuXeqgEMv18rwqoX6GU4FR3/EsSms
	u/FuwZ0vjn2KO0R2R6ltbenZFhUyt27h+ZJpKzl3sR1jn/H9iK0A1282H9XO3Vfb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213430>

On 01/13/2013 05:17 PM, John Keeping wrote:
> On Sun, Jan 13, 2013 at 04:26:39AM +0100, Michael Haggerty wrote:
>> On 01/12/2013 08:23 PM, John Keeping wrote:
>>> Although 2to3 will fix most issues in Python 2 code to make it run under
>>> Python 3, it does not handle the new strict separation between byte
>>> strings and unicode strings.  There is one instance in
>>> git_remote_helpers where we are caught by this.
>>>
>>> Fix it by explicitly decoding the incoming byte string into a unicode
>>> string.  In this instance, use the locale under which the application is
>>> running.
>>>
>>> Signed-off-by: John Keeping <john@keeping.me.uk>
>>> ---
>>>  git_remote_helpers/git/importer.py | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
>>> index e28cc8f..6814003 100644
>>> --- a/git_remote_helpers/git/importer.py
>>> +++ b/git_remote_helpers/git/importer.py
>>> @@ -20,7 +20,7 @@ class GitImporter(object):
>>>          """Returns a dictionary with refs.
>>>          """
>>>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
>>> -        lines = check_output(args).strip().split('\n')
>>> +        lines = check_output(args).decode().strip().split('\n')
>>>          refs = {}
>>>          for line in lines:
>>>              value, name = line.split(' ')
>>>
>>
>> Won't this change cause an exception if the branch names are not all
>> valid strings in the current locale's encoding?  I don't see how this
>> assumption is justified (e.g., see git-check-ref-format(1) for the rules
>> governing reference names).
> 
> Yes it will.  The problem is that for Python 3 we need to decode the
> byte string into a unicode string, which means we need to know what
> encoding it is.
> 
> I don't think we can just say "git-for-each-ref will print refs in
> UTF-8" since AFAIK git doesn't care what encoding the refs are in - I
> suspect that's determined by the filesystem which in the end probably
> maps to whatever bytes the shell fed git when the ref was created.
> 
> That's why I chose the current locale in this case.  I'm hoping someone
> here will correct me if we can do better, but I don't see any way of
> avoiding choosing some encoding here if we want to support Python 3
> (which I think we will, even if we don't right now).

I'm not just trying to be a nuisance here; I'm struggling myself to
understand how a program that cares about strings-vs-bytes (e.g., a
Python3 script) should coexist with a program that doesn't (e.g., git
[1]).  I think this will become a big issue if my Python version of the
commit email script ever gets integrated and then made compatible with
Python3.

You claim "for Python 3 we need to decode the byte string into a unicode
string".  I understand that Python 3 strings are Unicode, but why/when
is it necessary to decode data into a Unicode string as opposed to
leaving it as a byte sequence?

In this particular case (from a cursory look over the code) it seems to
me that (1) decoding to Unicode will sometimes fail for data that git
considers valid and (2) there is no obvious reason that the data cannot
be processed as byte sequences.

Michael

[1] And it doesn't just seem that "git doesn't care about Unicode
*yet*".  It seems more likely that "git will adamantly refuse to deal
with Unicode".  For example, Linus is quite clearly in favor of treating
data as byte sequences in most situations:
https://plus.google.com/111049168280159033135/posts/f3fngVm174f

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
