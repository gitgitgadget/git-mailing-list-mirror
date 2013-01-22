From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT get corrupted on lustre
Date: Tue, 22 Jan 2013 14:03:37 -0800
Message-ID: <7vip6onadi.fsf@alter.siamese.dyndns.org>
References: <50D861EE.6020105@giref.ulaval.ca>
 <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
 <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
 <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
 <50F8273E.5050803@giref.ulaval.ca>
 <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
 <50F829A9.7090606@calculquebec.ca>
 <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
 <50F98B53.9080109@giref.ulaval.ca>
 <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
 <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
 <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	kusmabite@gmail.com,
	"Pyeron\, Jason J CTR \(US\)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txlx1-00035v-CO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab3AVWDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 17:03:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab3AVWDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 17:03:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC7CB443;
	Tue, 22 Jan 2013 17:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+M8te9ZvstztbSTgw5CqSSWMkU=; b=tBKu9B
	RdL5PG1TcmxliugsoT0rWBPVBHdeTBwCt56McX8RSMksi+EfLZQmUp/PUcwJ+1Y2
	fG8IaithuPKSEt+rkUkIjJgC39s2cJBomgQRMiTcd7hje7E7D0PA8fYByItOiuP+
	5ci2XUOD+HtnEqWVDKHmu2fWgxfd4BnYB70d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9FfnRDO5g2m8JdpY+AkdrY+b0Zl5lDQ
	0Ajw98x0wiXUUmEzCvy42SOTpPMqC62yhtX39oVMqPGsv+KaCQv+kjnG9CfKO2Pz
	kyRp8wM8LwODAZeduQoG/V8VawFPRMVG3xjBA9ejf7KPRu2ZhF9EH8BPXCjPqUPa
	p6NRftZCW20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F28B442;
	Tue, 22 Jan 2013 17:03:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2596B43E; Tue, 22 Jan 2013
 17:03:38 -0500 (EST)
In-Reply-To: <50FF051D.5090804@giref.ulaval.ca> (Eric Chamberland's message
 of "Tue, 22 Jan 2013 16:31:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93809362-64DF-11E2-920C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214255>

Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:

> So, hum, do we have some sort of conclusion?
>
> Shall it be a fix for git to get around that lustre "behavior"?
>
> If something can be done in git it would be great: it is a *lot*
> easier to change git than the lustre filesystem software for a cluster
> in running in production mode... (words from cluster team) :-/

Do we know the real cause of the symptom?  I did not follow the
thread carefully, but the impression I was getting was that the
filesystem is broken around EINTR, and even if you "fix"ed Git,
your other more mission critical applications will be broken by
the same filesystem behaviour, no?
