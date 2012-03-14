From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 14 Mar 2012 10:54:49 +0100
Message-ID: <4F606AE9.70608@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><m3pqcjt6s2.fsf@carbon.jhcloos.org> <7v4ntvx87v.fsf@alter.siamese.dyndns.org><4F5F1FEA.8020103@seap.minhap.es> <7vhaxrsssm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7k1A-00048g-IV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 09:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375Ab2CNI5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 04:57:06 -0400
Received: from luthien2.map.es ([82.150.0.102]:59953 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759827Ab2CNI5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 04:57:03 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 6214824EDF;
	Wed, 14 Mar 2012 09:56:04 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 81B4C2C51E;
	Wed, 14 Mar 2012 09:55:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7vhaxrsssm.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 6214824EDF.D868E
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332320165.05987@iia+MCYuWajvoNizP/si+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193087>

On 03/14/2012 05:36 AM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> On 03/11/2012 08:12 PM, Junio C Hamano wrote:
>>> James Cloos <cloos@jhcloos.com> writes:
>>>
>>>> Please include a way, eg via ~/.gitconfig, to ignore any http_proxy in
>>>> the environment and connect directly.
>>>
>>> Hrm.
>>>
>>> I think without this patch series, the "NO_PROXY" environment
>>> variable is honored by the curl library when it uses http_proxy
>>> to make the decision. If this patch (or a future reroll of it) fails
>>> to do the same, it would be a regression.
>>>
>>> Nelson, do you agree?
>>
>> I agree, so I would need to handle $no_proxy in the patch-set, will look
>> into that.
> 
> Are you sure $no_proxy is spelled in lowercase?  man curl(1) seems to
> indicate otherwise.

Instead here[1] in section "Environment Variables" it's spelled lowercase,
and given that cURL reads $http_proxy only in lowercase I think it does
the same for $no_proxy.

[1] http://curl.haxx.se/libcurl/c/libcurl-tutorial.html
