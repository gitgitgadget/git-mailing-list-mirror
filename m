From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Mon, 02 Feb 2015 13:43:06 +0100
Message-ID: <54CF70DA.5090506@alum.mit.edu>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com> <cover.1422737997.git.johannes.schindelin@gmx.de> <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 02 13:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIGSz-0004fK-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 13:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbbBBMu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 07:50:56 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62346 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933206AbbBBMuN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 07:50:13 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Feb 2015 07:50:13 EST
X-AuditID: 12074414-f797f6d000004084-bf-54cf70dd9b63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BA.EE.16516.DD07FC45; Mon,  2 Feb 2015 07:43:09 -0500 (EST)
Received: from [192.168.69.130] (p4FC96EED.dip0.t-ipconnect.de [79.201.110.237])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t12Ch7Fh013646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 2 Feb 2015 07:43:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqHu34HyIwf0mEYuuK91MFg29V5gt
	+pd3sVn8aOlhdmDx+PAxzuNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M748Wole8ER
	oYqrkzYyNzC+5+ti5OSQEDCRWH7qOjOELSZx4d56ti5GLg4hgcuMEm9fb2UCSQgJnGeS6HzC
	CWLzCmhLbFq3lw3EZhFQlWg4+IYVxGYT0JVY1NMMVi8qECRxpWUzM0S9oMTJmU9YQGwRAXeJ
	jserwOLMAmoSy3/+ApsjLBArsWXJGSaIxXMZJQ6en8MIkuAUsJU49OE/E0SDnsSO679YIWx5
	ieats5knMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzRS00p
	3cQICWeRHYxHTsodYhTgYFTi4Z3w8VyIEGtiWXFl7iFGSQ4mJVFek9jzIUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeDUsgHK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwc
	ShK8N/OBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRpfDIxWkBQP0F6hApC9
	xQWJuUBRiNZTjIpS4rz/QOYKgCQySvPgxsKS1CtGcaAvhXn5Qdp5gAkOrvsV0GAmoMHLJp0B
	GVySiJCSamCscxJ/f08m6gmLp3vtwke5T3jOyawSNv8qOfusHzdHVolBhZa6r3Lcon3LuAV8
	nyeWTjQz/L81Kezi31u3PJfU2f46WjKr9s2k9dbX0y+du9az1Nz8W4Sl/4M8tsbP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263258>

On 02/02/2015 12:41 PM, Johannes Schindelin wrote:
> Hi all (in particular Junio),
> 
> On 2015-01-31 22:04, Johannes Schindelin wrote:
> 
>> [...] switch to fsck.severity to address Michael's concerns that
>> letting fsck.(error|warn|ignore)'s comma-separated lists possibly
>> overriding each other partially;
> 
> Having participated in the CodingStyle thread, I came to the
> conclusion that the fsck.severity solution favors syntax over
> intuitiveness.
> 
> Therefore, I would like to support the case for
> `fsck.level.missingAuthor` (note that there is an extra ".level." in
> contrast to earlier suggestions).

Why "level"?

> The benefits:
> 
> - it is very, very easy to understand
> 
> - cumulative settings are intuitively cumulative, i.e. setting
> `fsck.level.missingAuthor` will leave `fsck.level.invalidEmail`
> completely unaffected
> 
> - it is very easy to enquire and set the levels via existing `git
> config` calls
> 
> Now, there is one downside, but *only* if we ignore Postel's law.
> 
> Postel's law ("be lenient in what you accept as input, but strict in
> your output") would dictate that our message ID parser accept both
> "missing-author" and "missingAuthor" if we follow the inconsistent
> practice of using lowercase-dashed keys on the command-line but
> CamelCased ones in the config.
> 
> However, earlier Junio made very clear that the parser is required to
> fail to parse "missing-author" in the config, and to fail to parse
> "missingAuthor" on the command-line.
> 
> Therefore, the design I recommend above will require two, minimally
> different parsers for essentially the same thing.
> 
> IMHO this is a downside that is by far outweighed by the ease of use
> of the new feature, therefore I am willing to bear the burden of
> implementation.

I again encourage you to consider skipping the implementation of
command-line options entirely. It's not like users are going to want to
use different options for different invocations. Let them use

    git -c fsck.level.missingAuthor=ignore fsck

if they really want to play around, then

    git config fsck.level.missingAuthor ignore

to make it permanent. After that they will never have to worry about
that option again.

And Postel needn't be offended :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
