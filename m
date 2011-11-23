From: Paul Brossier <piem@piem.org>
Subject: Re: git not resuming push
Date: Wed, 23 Nov 2011 10:25:44 -0700
Message-ID: <4ECD2C98.8030004@piem.org>
References: <4ECC6F80.6010907@piem.org> <20111123050220.GA9127@sigill.intra.peff.net> <7vmxbncq5v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGaI-0002K1-0d
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab1KWR0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 12:26:04 -0500
Received: from goyave.piem.org ([213.251.135.79]:46692 "EHLO goyave.piem.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab1KWRZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 12:25:54 -0500
Received: from localhost ([127.0.0.1] helo=groseille.local)
	by goyave.piem.org with esmtp (Exim 4.72)
	(envelope-from <piem@piem.org>)
	id 1RTGZw-0005an-Gt; Wed, 23 Nov 2011 18:25:49 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vmxbncq5v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185858>

ok, that, with a bit of patience, should help!

thank you both for your answers,

piem

On 22/11/2011 23:24, Junio C Hamano wrote:
> Jeff King<peff@peff.net>  writes:
>
>> On Tue, Nov 22, 2011 at 08:58:56PM -0700, Paul Brossier wrote:
>>
>>> If the connection fails after uploading part of the data, it seems I
>>> need to start over from zero again. Is there a way to resume the upload
>>> instead?
>>
>> No, there isn't a way to resume just using push.
>>
>> If you have shell access on the server, one workaround you can do is to
>> create a bundle with the commits in question, upload it via some
>> resumable protocol (like sftp, http, rsync, etc), possibly taking many
>> attempts, and then fetch the result on the server side from the bundle
>> into the repository.
>>
>> See "git help bundle" for some examples.
>
> Another possibility, if it is the connection between you and the other
> side that is the problem, is to chunk your push in smaller pieces. That
> is, if you are trying to push out v3.0, you first push only to v1.0, then
> to v2.0, and then finally to v3.0.
>
> Peff, by the way, wouldn't this request reminds of us of a scenario we
> discussed recently, which I said I would imagine would be common while you
> dismissed as not likely to be common?
>
>
